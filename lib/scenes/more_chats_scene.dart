import 'dart:async';
import 'package:chatpot_app/entities/room.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/components/room_row.dart';
import 'package:chatpot_app/components/room_detail_sheet.dart';
import 'package:chatpot_app/storage/translation_cache_accessor.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

const DEFAULT_FETCH_SIZE = 7;

class RoomSearchCondition {
  String query;
  RoomQueryOrder order;

  RoomSearchCondition({
    String query,
    RoomQueryOrder order,
    
  }) {
    this.query = query;
    this.order = order;
  }

  @override
  String toString() =>
    "[RoomSearchCondition] ORDER:$order QUERY:$query";
}

class MoreChatsScene extends StatefulWidget {

  final RoomSearchCondition condition;

  MoreChatsScene({
    @required this.condition
  });

  @override
  _MoreChatsSceneState createState() =>
    _MoreChatsSceneState(condition: condition);
}

class _MoreChatsSceneState extends State<MoreChatsScene> {

  RoomSearchCondition _condition;
  bool _loading;
  List<Room> _rooms;
  int _offset;
  int _numAllRooms;

  TextEditingController _queryEditController;

  _MoreChatsSceneState({
    @required RoomSearchCondition condition
  }) {
    _rooms = List();
    _condition = condition;
    _loading = false;
    _queryEditController = TextEditingController();
    _offset = 0;
    _numAllRooms = 0;
  }

  @override
  initState() {
    super.initState();
    print(_condition.order);
    this._refreshSearch();
  }

  Future<void> _refreshSearch() async {
    setState(() {
      _loading = true;
      _offset = 0;
    });

    var searchResp = await roomApi().requestPublicRooms(
      order: _condition.order,
      offset: _offset,
      size: DEFAULT_FETCH_SIZE,
      keyword: _condition.query != null ?
                _condition.query.trim().length == 0 ? null : _condition.query 
              : null
    );

    setState(() {
      _rooms = searchResp.list;
      _numAllRooms = searchResp.all;
      _loading = false;
    });
    await _translateRoomTitles();
  }

  Future<void> _translateRoomTitles() async {
    final state = ScopedModel.of<AppState>(context);
    Map<String, TranslateParam> paramMap = Map();
    this._rooms.forEach((r) {
      if (r.owner.language == state.member.language) return;
      paramMap[r.roomToken] = TranslateParam(
        from: r.owner.language,
        key: r.roomToken,
        message: r.title);
    });

    List<TranslateParam> queries =
      paramMap.keys.map((k) => paramMap[k]).toList();

    List<String> cacheQueries = queries.map((q) => q.key).toList();
    List<Translated> cachedTranslations = await
      translationCacheAccessor().getCachedRoomTitleTranslations(keys: cacheQueries);

    // apply cached translation to room title.
    cachedTranslations.forEach((t) {
      List<Room> foundInRooms = _rooms.where((r) => r.roomToken == t.key).toList();
      if (foundInRooms.length > 0) {
        setState(() {
          foundInRooms[0].titleTranslated = t.translated;
        });
      }
    });

    List<TranslateParam> filteredQuery = 
      queries.where((q) =>
         cachedTranslations.where((c) => 
          c.key == q.key).length == 0).toList();

    if (filteredQuery.length > 0) {
      var apiResp = await translateApi().requestTranslateRooms(
        toLocale: state.member.language,
        queries: filteredQuery
      );

      apiResp.forEach((t) {
        List<Room> foundInRooms = _rooms.where((r) => r.roomToken == t.key).toList();
        if (foundInRooms.length > 0) {
          setState(() {
            foundInRooms[0].titleTranslated = t.translated;
          });
        }
      });
      
      if (apiResp.length > 0) {
        List<Translated> cacheParams = 
        apiResp.map((r) => Translated(
          key: r.key,
          translated: r.translated
        )).toList();
        await translationCacheAccessor().cacheRoomTitleTranslations(translated: cacheParams);
      }
    }
  }

  Future<void> _moreSearch() async {
    setState(() {
      _loading = true;
      _offset += DEFAULT_FETCH_SIZE;
    });

    var searchResp = await roomApi().requestPublicRooms(
      order: _condition.order,
      offset: _offset,
      size: DEFAULT_FETCH_SIZE,
      keyword: _condition.query != null ?
                _condition.query.trim().length == 0 ? null : _condition.query 
              : null
    );
    setState(() {
      _rooms.addAll(searchResp.list);
      _numAllRooms = searchResp.all;
      _loading = false;
    });
    await _translateRoomTitles();
  }

  Future<void> _onPickerSelected(RoomQueryOrder order) async {
    _condition.order = order;
    _offset = 0;
    await _refreshSearch();
  }

  Future<void> _onRoomSelected(BuildContext context, Room r) async {
    bool isJoin = await showRoomDetailSheet(context, r);
    if (isJoin == true) {
      setState(() => _loading = true);
      final state = ScopedModel.of<AppState>(context);
      var resp = await state.joinToRoom(r.roomToken);

      try {
        if (resp.success == true) {
          await showSimpleAlert(context, 'You have successfully joined the chat room.', title: locales().successTitle);
        } else {
          await showSimpleAlert(context, locales().error.messageFromErrorCode(resp.cause));
        }
      } finally {
        setState(() => _loading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: _buildPicker(context, 
          callback: _onPickerSelected,
          selected: _condition.order
        )
      ),
      Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: _buildCompoundSearchArea(context,
          controller: _queryEditController,
          textChangeCallback: (String query) => _condition.query = query,
          loading: _loading,
          clickCallback: () => this._refreshSearch()
        )
      )
    ];

    List<Widget> roomWidgets = 
      _rooms.map((r) => RoomRow(
        room: r,
        rowClickCallback: (Room r) => _onRoomSelected(context, r)
      )).toList();
    widgets.addAll(roomWidgets);

    widgets.add(_buildMoreRoomButton(context,
      clickCallback: () => _moreSearch(),
      loading: _loading,
      rooms: _rooms,
      numAllRooms: _numAllRooms
    ));

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: locales().home.title,
          middle: Text(locales().morechat.title),
          transitionBetweenRoutes: true
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView(children: widgets),
              Positioned(
                child: _buildProgress(context,
                  loading: _loading
                )
              )
            ]
          )
        )
      );
  }
}

typedef QueryTextChangeCallback (String query);
typedef OrderSelectCallback (RoomQueryOrder order);
Widget _buildPicker(BuildContext context, {
  @required RoomQueryOrder selected,
  @required OrderSelectCallback callback
}) {
  List<RoomQueryOrder> items = [
    RoomQueryOrder.ATTENDEE_DESC,
    RoomQueryOrder.REGDATE_DESC
  ];
  return Center();
}

String _orderLabel(RoomQueryOrder order) =>
  order == RoomQueryOrder.ATTENDEE_DESC ? locales().morechat.orderPeopleDesc :
  order == RoomQueryOrder.REGDATE_DESC ? locales().morechat.orderRecentDesc : '';

Widget _buildQueryInputField(BuildContext context, {
  @required TextEditingController controller,
  @required QueryTextChangeCallback textChangeCallback
}) =>
  CupertinoTextField(
    controller: controller,
    prefix: const Icon(
      CupertinoIcons.search,
      color: CupertinoColors.lightBackgroundGray,
      size: 28.0,
    ),
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    clearButtonMode: OverlayVisibilityMode.editing,
    textCapitalization: TextCapitalization.words,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray)),
    ),
    placeholder: locales().morechat.queryEditPlaceholder
  );

Widget _buildCompoundSearchArea(BuildContext context, {
  @required TextEditingController controller,
  @required QueryTextChangeCallback textChangeCallback,
  @required VoidCallback clickCallback,
  @required bool loading}) =>
  Row(
    children: [
      Expanded(
        child: _buildQueryInputField(context,
          controller: controller,
          textChangeCallback: textChangeCallback
        )
      ),
      _buildSearchButton(context,
        clickCallback: clickCallback,
        loading: loading
      )
    ]
  );

Widget _buildSearchButton(BuildContext context, {
  @required VoidCallback clickCallback,
  @required bool loading
}) =>
  CupertinoButton(
    child: Text(locales().morechat.searchButtonLabel),
    onPressed: loading == true ? null : clickCallback
  );

Widget _buildMoreRoomButton(BuildContext context, {
  @required VoidCallback clickCallback,
  @required bool loading,
  @required List<Room> rooms,
  @required int numAllRooms
}) {
  if (rooms.length >= numAllRooms) return Container();
  if (loading == true) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: CupertinoActivityIndicator()
    );
  }
  return CupertinoButton(
    child: Text(locales().morechat.loadMoreButtonLabel),
    onPressed: loading == true ? null : clickCallback
  );
}

Widget _buildConditionIndicator(BuildContext context, {
  @required bool loading
}) =>
  Row(
    children: [

    ]
  );

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();
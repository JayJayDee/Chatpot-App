import 'dart:async';
import 'package:chatpot_app/entities/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/room_row.dart';

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
      size: DEFAULT_FETCH_SIZE
    );
    setState(() {
      _rooms = searchResp.list;
      _numAllRooms = searchResp.all;
      _loading = false;
    });
  }

  Future<void> _moreSearch() async {
    setState(() {
      _loading = true;
      _offset += DEFAULT_FETCH_SIZE;
    });

    var searchResp = await roomApi().requestPublicRooms(
      order: _condition.order,
      offset: _offset,
      size: DEFAULT_FETCH_SIZE
    );
    setState(() {
      _rooms.addAll(searchResp.list);
      _numAllRooms = searchResp.all;
      _loading = false;
    });
  }

  Future<void> _onPickerSelected(RoomQueryOrder order) async {
    _condition.order = order;
    _offset = 0;
    await _refreshSearch();
  }

  Future<void> _onRoomSelected(Room r) async {
    print(r);
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
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: _buildQueryInputField(context,
          controller: _queryEditController,
          textChangeCallback: (String query) => print(query)
        )
      ),
      Container(
        child: _buildSearchButton(context,
          loading: _loading,
          clickCallback: () {
            this._refreshSearch();
          }
        )
      )
    ];

    List<Widget> roomWidgets = 
      _rooms.map((r) => RoomRow(
        room: r,
        rowClickCallback: _onRoomSelected,
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
  return CupertinoButton(
    child: Text(locales().morechat.loadMoreButtonLabel),
    onPressed: loading == true ? null : clickCallback
  );
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();
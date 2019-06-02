import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/factory.dart';

class RoomSearchCondition {
  String query;
  RoomQueryOrder order;

  RoomSearchCondition({
    String query,
    RoomQueryOrder order
  }) {
    this.query = query;
    this.order = order;
  }
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

  _MoreChatsSceneState({
    @required RoomSearchCondition condition
  }) {
    _condition = condition;
  }

  @override
  initState() {
    super.initState();
    _loading = false;
  }

  Future<void> _refreshSearch() async {
    setState(() {
      _loading = true;
    });
  }

  Future<void> _onPickerSelected(RoomQueryOrder order) async {
    _condition.order = order;
    await _refreshSearch();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: locales().home.title,
          middle: Text(locales().morechat.title),
          transitionBetweenRoutes: true
        ),
        child: SafeArea(
          child: ListView(
            children: [
              _buildPicker(context,
                callback: _onPickerSelected,
                selected: _condition.order
              )
            ]
          )
        )
      );
  }
}

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
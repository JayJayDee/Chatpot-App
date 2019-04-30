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

  _MoreChatsSceneState({
    @required RoomSearchCondition condition
  }) {
    _condition = condition;
  }

  @override
  initState() {
    super.initState();
    print(_condition.order);
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
            ]
          )
        )
      );
  }
}

typedef OrderSelectCallback (RoomQueryOrder order);
Widget _buildPicker(BuildContext context, {
  @required OrderSelectCallback callback
}) {
  List<RoomQueryOrder> orders = [
    RoomQueryOrder.ATTENDEE_DESC,
    RoomQueryOrder.REGDATE_DESC
  ];

  return CupertinoPicker(
    children: List<Widget>.generate(orders.length, (int idx) =>
      Center(
        child: Text(orderLabel(orders[idx]))
      )
    ),
    itemExtent: 32.0,
    diameterRatio: 32.0,
    onSelectedItemChanged: (int idx) {
      if (callback != null) callback(orders[idx]);
    }
  );
}

String orderLabel(RoomQueryOrder order) =>
  order == RoomQueryOrder.ATTENDEE_DESC ? locales().morechat.orderPeopleDesc :
  order == RoomQueryOrder.REGDATE_DESC ? locales().morechat.orderRecentDesc : '';
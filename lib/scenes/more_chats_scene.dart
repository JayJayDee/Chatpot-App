import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class RoomSearchCondition {
  String query;
  RoomQueryOrder order;
  RoomSearchCondition({
    String query,
    RoomQueryOrder order
  }) {
    query = query;
    order = order;
  }
}

class MoreChatsScene extends StatefulWidget {

  final RoomSearchCondition condition;

  MoreChatsScene(
    this.condition
  );

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
    print(_condition.order);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Back',
          middle: Text('More chats'),
          transitionBetweenRoutes: true
        ),
        child: SafeArea(
          child: Center()
        )
      );
  }
}
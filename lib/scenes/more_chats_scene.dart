import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
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

@immutable
class MoreChatsScene extends StatelessWidget {

  final RoomSearchCondition condition;

  MoreChatsScene(
    this.condition
  );

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
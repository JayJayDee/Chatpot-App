import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/room.dart';

@immutable
class MessageScene extends StatelessWidget {

  final MyRoom room;

  MessageScene({
    this.room
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Chats',
        middle: Text(room.title), 
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Center(

        )
      )
    );
  }
}
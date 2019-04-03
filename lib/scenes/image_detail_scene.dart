import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/styles.dart';

class ImageDetailScene extends StatelessWidget {

  ImageDetailScene({
    this.room,
    this.message
  });

  final MyRoom room;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Chatting',
        middle: Text('image'),
        transitionBetweenRoutes: true,
      ),
      child: SafeArea(
        child: Center()
      )
    );
  }
}
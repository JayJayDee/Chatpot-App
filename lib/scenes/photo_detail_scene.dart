import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class PhotoDetailScene extends StatefulWidget {
  
  final List<Message> messages;
  final String selectedMessageId;

  PhotoDetailScene(
    this.messages,
    this.selectedMessageId
  );

  @override
  _PhotoDetailSceneState createState() => _PhotoDetailSceneState();
}

class _PhotoDetailSceneState extends State<PhotoDetailScene> {

  Message _selectedMessage;

  _PhotoDetailSceneState() {
    
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().photoDetail.previousTitle,
        middle: Text(locales().photoDetail.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Center()
      )
    );
  }
}
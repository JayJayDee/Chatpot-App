import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class ImageSendConfirmScene extends StatefulWidget {
  @override
  State createState() => _ImageSendConfirmSceneState();
}

class _ImageSendConfirmSceneState extends State<ImageSendConfirmScene> {

  final String roomTitle;
  final File selectedImageFile;

  _ImageSendConfirmSceneState({
    this.roomTitle,
    this.selectedImageFile
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: roomTitle,
        middle: Text(locales().imageConfirmScene.title)
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [

          ]
        )
      ),
    );
  }
}
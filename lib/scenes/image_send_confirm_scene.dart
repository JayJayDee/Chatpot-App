import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class ImageSendConfirmScene extends StatefulWidget {

  final String roomTitle;
  final File selectedImageFile;

  ImageSendConfirmScene({
    @required this.roomTitle,
    @required this.selectedImageFile
  });

  @override
  State createState() => _ImageSendConfirmSceneState(
    roomTitle: roomTitle,
    selectedImageFile: selectedImageFile
  );
}

class _ImageSendConfirmSceneState extends State<ImageSendConfirmScene> {

  final String roomTitle;
  final File selectedImageFile;

  _ImageSendConfirmSceneState({
    @required this.roomTitle,
    @required this.selectedImageFile
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
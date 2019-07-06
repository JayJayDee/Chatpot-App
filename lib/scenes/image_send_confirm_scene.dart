import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatpot_app/factory.dart';

class ImageSendConfirmScene extends StatefulWidget {

  final String roomTitle;

  ImageSendConfirmScene({
    @required this.roomTitle
  });

  @override
  State createState() => _ImageSendConfirmSceneState(
    roomTitle: roomTitle
  );
}

class _ImageSendConfirmSceneState extends State<ImageSendConfirmScene> {

  final String roomTitle;

  bool _loading;
  Image _selectedImage;

  _ImageSendConfirmSceneState({
    @required this.roomTitle
  }) {
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: roomTitle,
        middle: Text(locales().imageConfirmScene.title),
        trailing: Text(locales().imageConfirmScene.btnSelectImage),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: _buildImageShownArea(context, image: _selectedImage)
                ),
                _buildSavedZzalArea(context, loading: _loading)
              ]
            ),
            Positioned(
              child: _buildProgress(context, loading: _loading)
            )
          ]
        )
      ),
    );
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() :
  Container();

Widget _buildImageShownArea(BuildContext context, {
  @required Image image
}) =>
  Container(
    color: CupertinoColors.inactiveGray,
  );

Widget _buildSavedZzalArea(BuildContext context, {
  @required bool loading
}) =>
  Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: Text('Saved Memes')
        ),
        Container(
          height: 60
        )
      ]
    )
  );
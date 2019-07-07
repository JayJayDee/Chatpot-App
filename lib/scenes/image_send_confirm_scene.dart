import 'dart:io';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

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
  bool _isZzalSave;
  Image _selectedImage;
  List<MyAssetResp> _myZzals;
  
  _ImageSendConfirmSceneState({
    @required this.roomTitle
  }) {
    _loading = false;
    _isZzalSave = false;
  }

  void _onSendClicked() async {
    if (_selectedImage == null) {
      await showSimpleAlert(context, locales().imageConfirmScene.imageSelectionRequired);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMyZzals();
  }

  void _loadMyZzals() async {
    setState(() => _loading = true);
    final state = ScopedModel.of<AppState>(context);

    try {
      List<MyAssetResp> list = await assetApi().getMyMemes(memberToken: state.member.token);
      setState(() {
        _myZzals = list;
      });

    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: roomTitle,
        middle: Text(locales().imageConfirmScene.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text(locales().imageConfirmScene.btnSendImage),
          onPressed: () => _onSendClicked(),
        )
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: _buildImageShownArea(context,
                    image: _selectedImage,
                    isZzalSave: _isZzalSave
                  )
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
  @required Image image,
  @required bool isZzalSave
}) =>
  Container(
    color: CupertinoColors.lightBackgroundGray,
    child: Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Center(
          child: Icon(MdiIcons.image,
            color: Styles.primaryFontColor,
            size: 50
          ),
        )
      ]
    )
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
          child: Text(locales().imageConfirmScene.savedMemesTitle,
            style: TextStyle(
              color: Styles.primaryFontColor,
              fontSize: 16
            )
          )
        ),
        Container(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [

            ]
          ),
        )
      ]
    )
  );

typedef ZzalSelectCallback (AssetUploadResp asset);

Widget _buildZzalRow(BuildContext context, {
  @required AssetUploadResp asset,
  @required bool loading,
  @required ZzalSelectCallback callback
}) =>
  CupertinoButton(
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          width: 70,
          height: 70,
          color: CupertinoColors.activeBlue,
        )
      ]
    ),
    onPressed: loading == true ? null :
      () => callback(asset)
  );
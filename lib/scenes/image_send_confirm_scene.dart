import 'dart:io';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/models/app_state.dart';

class SelectedImage {
  final String image;
  final String thumbnail;

  SelectedImage({
    @required this.image,
    @required this.thumbnail
  });
}

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
  bool _isUploading;
  bool _gallerySelected;
  Widget _selectedImage;
  int _uploadProgress;

  File _selectedGalleryFile;
  MyAssetResp _selectedPrevZzal;

  List<MyAssetResp> _myZzals;
  
  _ImageSendConfirmSceneState({
    @required this.roomTitle
  }) {
    _loading = false;
    _isUploading = false;
    _gallerySelected = false;
    _uploadProgress = 0;
  }

  void _onSendClicked() async {
    if (_selectedImage == null) {
      await showSimpleAlert(context, locales().imageConfirmScene.imageSelectionRequired);
      return;
    }

    // case of gallery.
    if (_gallerySelected == true) {
      setState(() {
        _loading = true;
        _isUploading = true;
      });

      try {
        var uploaded = await assetApi().uploadImage(_selectedGalleryFile,
          callback: (dynamic value) {
            int progress = value;
            setState(() {
              _uploadProgress = progress;
            });
          }
        );
        SelectedImage resp = SelectedImage(
          image: uploaded.orig,
          thumbnail: uploaded.thumbnail
        );
        Navigator.of(context).pop(resp);

      } catch (err) {
        if (err is ApiFailureError) {
          await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        } else {
          throw err;
        }
      } finally {
        setState(() {
          _loading = false;
          _isUploading = false;
        });
      }
    }

    // case of previous zzal
    else if (_gallerySelected == false) {
      SelectedImage resp = SelectedImage(
        image: _selectedPrevZzal.orig,
        thumbnail: _selectedPrevZzal.thumbnail
      );
      Navigator.of(context).pop(resp);
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

  void _onGallerySelectClicked(BuildContext context) async {
    setState(() => _loading = true);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);

    try {
      if (file != null) {
        setState(() {
          _selectedImage = Image.file(file);
          _gallerySelected = true;
          _selectedPrevZzal = null;
          _selectedGalleryFile = file;
        });
      }
    } catch (err) {
      throw err;
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onNewZzalClicked(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);

    try {
      if (file == null) return;
      final state = ScopedModel.of<AppState>(context);

      setState(() {
        _isUploading = true;
        _uploadProgress = 0;
      });

      await assetApi().uploadNewMeme(file,
        memberToken: state.member.token,
        callback: (dynamic value) {
          int progress = value;
          setState(() {
            _uploadProgress = progress;
          });
        }
      );

    } catch (err) {
      throw err;
    } finally {
      setState(() {
        _isUploading = false;
        _loading = false;
      });
      _loadMyZzals();
    }
  }

  void _onExistZzalClicked(BuildContext context, MyAssetResp asset) async {
    setState(() {
      _selectedImage = CachedNetworkImage(
        imageUrl: asset.orig,
        placeholder: (conext, url) => CupertinoActivityIndicator()
      );

      _selectedPrevZzal = asset;
      _gallerySelected = false;
      _selectedGalleryFile = null;
    });
  }

  void _onImageDelete(BuildContext context, MyAssetResp asset) async {
    setState(() => _loading = true);
    try {
      final state = ScopedModel.of<AppState>(context);
      await assetApi().deleteMyMeme(
        memeId: asset.memeId,
        memberToken: state.member.token,
      );
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      }
    } finally {
      setState(() => _loading = false);
      _loadMyZzals();
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
          onPressed: _loading == true ? null :  () => _onSendClicked(),
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
                    loading: _loading,
                    image: _selectedImage,
                    gallerySelectCallback: () => _onGallerySelectClicked(context)
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: _buildSavedZzalArea(context,
                    loading: _loading,
                    selectCallback: (MyAssetResp asset) => _onExistZzalClicked(context, asset),
                    deleteCallback: (MyAssetResp asset) => _onImageDelete(context, asset),
                    newZzalCallback: () => _onNewZzalClicked(context),
                    zzals: _myZzals
                  )
                )
              ]
            ),
            Positioned(
              child: _buildProgress(context,
                loading: _loading,
                isUploading: _isUploading,
                progress: _uploadProgress
              )
            )
          ]
        )
      ),
    );
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading,
  @required bool isUploading,
  @required int progress
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      loading == true ? CupertinoActivityIndicator() : Container(),
      Positioned(
        child: isUploading == true ?
          Container(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(CupertinoColors.activeBlue),
              strokeWidth: 8,
            )
          ) : Container()
      ),
      Positioned(
        child: isUploading == true ?
          Text("$progress%",
            style: TextStyle(
              color: CupertinoColors.activeBlue,
              fontSize: 17
            )
          ) : Container()
      )
    ]
  );
}
  

Widget _buildImageShownArea(BuildContext context, {
  @required bool loading,
  @required Widget image,
  @required VoidCallback gallerySelectCallback
}) =>
  Container(
    color: CupertinoColors.lightBackgroundGray,
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        image == null ?
          Center(
            child: Icon(MdiIcons.image,
              color: Styles.secondaryFontColor,
              size: 50
            ),
          ) : Container(
            alignment: Alignment.center,
            color: CupertinoColors.lightBackgroundGray,
            child: image,
          ),
        Container(
          margin: EdgeInsets.all(10),
          child: CupertinoButton(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: Text(locales().imageConfirmScene.btnSelectImageFromGallery),
            onPressed: loading == true ? null : gallerySelectCallback,
            color: Styles.primaryFontColor,
          ),
        )
      ]
    )
  );

Widget _buildSavedZzalArea(BuildContext context, {
  @required bool loading,
  @required List<MyAssetResp> zzals,
  @required ZzalSelectCallback selectCallback,
  @required ZzalSelectCallback deleteCallback,
  @required VoidCallback newZzalCallback
}) {
  List<Widget> widgets = List();
  widgets.add(Container(
    margin: EdgeInsets.all(2),
    child: CupertinoButton(
      padding: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: Styles.secondaryFontColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        width: 70,
        height: 70,
        child: Icon(MdiIcons.plus,
          color: CupertinoColors.white
        )
      ),
      onPressed: loading == true ? null : newZzalCallback
    )
  ));

  if (zzals != null) {
    List<Widget> zzalRows = zzals.map((z) =>
      _buildZzalRow(context, 
        asset: z,
        loading: loading,
        selectCallback: selectCallback,
        deleteCallback: deleteCallback
      )).toList();
    widgets.addAll(zzalRows);
  }

  return Container(
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
            children: widgets
          ),
        )
      ]
    )
  );
}

typedef ZzalSelectCallback (MyAssetResp asset);

Widget _buildZzalRow(BuildContext context, {
  @required MyAssetResp asset,
  @required bool loading,
  @required ZzalSelectCallback selectCallback,
  @required ZzalSelectCallback deleteCallback
}) =>
  Container(
    margin: EdgeInsets.all(2),
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        CupertinoButton(
          padding: EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: asset.thumbnail,
              placeholder: (conext, url) => CupertinoActivityIndicator(),
              width: 70,
              height: 70,
            )
          ),
          onPressed: loading == true ? null :
            () => selectCallback(asset)
        ),
        Positioned(
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Container(
              color: CupertinoColors.destructiveRed,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(MdiIcons.minus,
                color: CupertinoColors.white,
              )
            ),
            onPressed: loading == true ? null :
              () => deleteCallback(asset)
          )
        )
      ]
    )
  );
  
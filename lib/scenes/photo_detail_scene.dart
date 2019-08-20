import 'dart:async';
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:meta/meta.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoDetailScene extends StatefulWidget {

  final BuildContext messagesSceneContext;
  final Message message;

  PhotoDetailScene({
    @required this.messagesSceneContext,
    @required this.message
  });

  @override
  _PhotoDetailSceneState createState() => _PhotoDetailSceneState(
    message: message,
  );
}

class _PhotoDetailSceneState extends State<PhotoDetailScene> {

  Message _message;
  bool _loading;
  bool _imageDownloading;

  int _allBytes;
  int _downloadedBytes;

  _PhotoDetailSceneState({
    @required Message message
  }) {
    _message = message;
    _loading = false;
    _imageDownloading = false;
    _allBytes = 0;
    _downloadedBytes = 0;
  }

  Future<void> _onImageDownloadClicked(BuildContext context, String imageUrl) async {
    if (Platform.isIOS) {
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
      PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    if (Platform.isAndroid) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _loading = true;
      _imageDownloading = true;
      _allBytes = 0;
      _downloadedBytes = 0;
    });

    var dio = Dio();

    try {
      var resp = await dio.get(imageUrl,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (received, total) {
          setState(() {
            _allBytes = total;
            _downloadedBytes = received;
          });
        }
      );

      ImagePickerSaver.saveFile(
          fileData: Uint8List.fromList(resp.data));

      showSimpleAlert(context, locales().photoDetail.downloadSuccess,
        title: locales().successTitle);
    } catch (err) {
      showSimpleAlert(context, locales().photoDetail.failedToDownload(err.toString()));
    } finally {
      setState(() {
        _loading = false;
        _imageDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().photoDetail.previousTitle,
        actionsForegroundColor: styles().link,
        middle: Text(locales().photoDetail.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
        trailing: _imageDownloading == true ? CupertinoActivityIndicator() :
          CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text(locales().photoDetail.btnDownload,
            style: TextStyle(
              color: styles().link,
            )
          ),
          onPressed: _loading == true ? null : () {
            _onImageDownloadClicked(context, _message.getImageContent().imageUrl);
          },
        ),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _buildImagePage(context, _message),

                _imageDownloading == true ? 
                  Positioned(
                    child: _buildImageDownloadIndicator(context,
                      downloaded: _downloadedBytes,
                      imageSize: _allBytes
                    )
                  ) : 
                  Container()
              ]
            ),
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.8)
                        ]
                      )
                    ),
                    height: 140,
                    child: _overlayIndicator(_message)
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  Widget _overlayIndicator(Message selected) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 10),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 60,
                  height: 60,
                  child: CachedNetworkImage(
                    imageUrl: selected.from.avatar.thumb,
                  )
                )
              ),
              Positioned(
                child: Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: locales().getFlagImage(selected.from.region),
                      fit: BoxFit.cover
                    )
                  ),
                )
              )
            ]
          ),
          Padding(padding: EdgeInsets.only(left: 15)),
          Text(locales().getNick(selected.from.nick),
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold
            )
          )
        ]
      )
    );
  }
}

Widget _buildImagePage(BuildContext context, Message message) {
  return Container(
    color: CupertinoColors.black,
    alignment: Alignment.center,
    child: PhotoView(
      backgroundDecoration: BoxDecoration(
        color: CupertinoColors.black
      ),
      imageProvider: CachedNetworkImageProvider(
        message.getImageContent().imageUrl
      )
    )
  );
}

Widget _buildImageDownloadIndicator(BuildContext context, {
  @required int imageSize,
  @required int downloaded
}) {
  double progress = 0;
  if (imageSize != 0 && downloaded != 0) {
    progress = downloaded / imageSize;
  }
  int intProg = (progress * 100.0).round();

  return Container(
    width: 90,
    height: 90,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: styles().mainBackground,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Text("$intProg%",
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 15
          )
        ),
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            value: progress,
            valueColor: AlwaysStoppedAnimation<Color>(styles().link)
          )
        )
      ]
    )
  );
}
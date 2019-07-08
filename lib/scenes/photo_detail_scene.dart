import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

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

  _PhotoDetailSceneState({
    @required Message message
  }) {
    _message = message;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().photoDetail.previousTitle,
        middle: Text(locales().photoDetail.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text('Download'),
          onPressed: () {} // TODO: to be implemented
        ),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: _buildImagePage(context, _message),
            ),
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _overlayIndicator(_message)
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
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(locales().getNick(selected.from.nick),
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 16
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
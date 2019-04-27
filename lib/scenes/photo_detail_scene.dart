import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class PhotoDetailScene extends StatefulWidget {

  final BuildContext messagesSceneContext;
  final List<Message> messages;
  final String selectedMessageId;

  PhotoDetailScene(
    this.messagesSceneContext,
    this.messages,
    this.selectedMessageId
  );

  @override
  _PhotoDetailSceneState createState() => _PhotoDetailSceneState(
    messages: messages,
    selectedMessageId: selectedMessageId
  );
}

class _PhotoDetailSceneState extends State<PhotoDetailScene> {

  int _selectedIdx;
  List<Message> _imageMessages;

  _PhotoDetailSceneState({
    @required List<Message> messages,
    @required String selectedMessageId
  }) {
    _imageMessages = messages.where((m) =>
      m.messageType == MessageType.IMAGE).toList();

    int idx = 0;
    for (int i = 0; i < _imageMessages.length; i++) {
      if (_imageMessages[i].messageId == selectedMessageId) {
        idx = i;
        break;
      }
    }
    _selectedIdx = idx;
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
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: Swiper(
                itemBuilder: (BuildContext context, int idx) =>
                  _buildImagePage(context, _imageMessages[idx], idx),
                itemCount: _imageMessages.length,
                index: _selectedIdx,
                onIndexChanged: (int idx) {
                  print("CURRENT IDX = $idx");
                  setState(() {
                    _selectedIdx = idx;
                  });
                },
              )
            ),
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _overlayIndicator(_imageMessages, _selectedIdx)
                ]
              )
            )
          ]
        )
      )
    );
  }

  Widget _overlayIndicator(List<Message> messages, int idx) {
    Message selected = messages[idx];
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

Widget _buildImagePage(BuildContext context, Message message, int idx) {
  return Container(
    color: CupertinoColors.black,
    alignment: Alignment.center,
    child: PhotoView(
      imageProvider: NetworkImage(
        message.getImageContent().imageUrl
      ),
    )
  );
}
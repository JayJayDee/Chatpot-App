import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:photo_view/photo_view.dart';
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
            Swiper(
              itemBuilder: (BuildContext context, int idx) =>
                _buildImagePage(context, _imageMessages[idx], idx),
              itemCount: _imageMessages.length,
              index: _selectedIdx,
              onIndexChanged: (int idx) {
                print("CURRENT IDX = $idx");
              },
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('TEST',
                    style: TextStyle(
                      color: CupertinoColors.white
                    )
                  ),
                  Text('TEST',
                    style: TextStyle(
                      color: CupertinoColors.white
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  Widget _overlayIndicator(BuildContext context) {
    return Container(

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
import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/components/message_row.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

@immutable
class MessageScene extends StatefulWidget {

  MessageScene();

  @override
  _MessageSceneState createState() => _MessageSceneState();
}

class _MessageSceneState extends State<MessageScene> {

  bool _inited = false;
  AppState _model;
  String _inputedMessage;
  TextEditingController _messageInputFieldCtrl = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<void> _onImageSentClicked(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    
    assetApi().uploadImage(image);
    // TODO: image upload.
  }

  Future<void> _onMessageSend(BuildContext context) async {
    if (_inputedMessage == null || _inputedMessage.trim().length == 0) {
      Toast.show('message was empty.', context, duration: 2);
      return;
    }

    final model = ScopedModel.of<AppState>(context);
    model.publishMessage(
      content: _inputedMessage,
      type: MessageType.TEXT
    );
    _messageInputFieldCtrl.clear();
    _inputedMessage = '';
  }

  Future<void> _onSceneShown(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    _model = model;
    MyRoom room = model.currentRoom;
    room.messages.clearNotViewed();
    await model.fetchMoreMessages(roomToken: room.roomToken);
  }

  Future<void> _onRoomLeaveClicked(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    bool isLeave = await _showLeaveDialog(context);
    if (isLeave == true) {
      await model.leaveFromRoom(model.currentRoom.roomToken);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _inited = false;
    _model.outFromRoom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_inited == false) {
      _inited = true;
      _onSceneShown(context);
    }
    final model = ScopedModel.of<AppState>(context);
    MyRoom room = model.currentRoom;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().chats.title,
        middle: Text(room.title), 
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text(locales().msgscene.leave),
          onPressed: () => _onRoomLeaveClicked(context)
        ),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  child: _buildListView(context,
                    controller: _scrollController
                  )
                ),
                _buildEditText(context, 
                  controller: _messageInputFieldCtrl,
                  valueChanged: (String value) => setState(() => _inputedMessage = value),
                  imageSelected: () => _onImageSentClicked(context),
                  sendClicked: () => _onMessageSend(context)
                )
              ]
            ),
            Positioned(
              child: _buildProgressBar(context)
            )
          ],
        )
      )
    );
  }
}

Widget _buildListView(BuildContext context, {
  @required ScrollController controller
}) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  return ListView.builder(
    scrollDirection: Axis.vertical,
    reverse: true,
    physics: AlwaysScrollableScrollPhysics(),
    controller: controller,
    itemCount: model.currentRoom.messages.messages.length,
    itemBuilder: (BuildContext context, int idx) {
      Message msg = model.currentRoom.messages.messages[idx];
      return MessageRow(message: msg, state: model);
    }
  );
}

Widget _buildEditText(BuildContext context, {
  @required TextEditingController controller,
  @required ValueChanged<String> valueChanged,
  @required VoidCallback imageSelected,
  @required VoidCallback sendClicked
}) {
  return Container(
    height: 50,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.photo),
          onPressed: imageSelected
        ),
        Expanded(
          child: CupertinoTextField(
            controller: controller,
            padding: EdgeInsets.all(5),
            style: TextStyle(
              fontSize: 17,
              color: Styles.primaryFontColor
            ),
            onChanged: valueChanged,
          )
        ),
        CupertinoButton(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.send),
          onPressed: sendClicked
        )
      ],
    ),
  );   
}

Widget _buildProgressBar(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (model.loading == false) return Center();
  return CupertinoActivityIndicator();
}

Future<bool> _showLeaveDialog(BuildContext context) async =>
  showCupertinoDialog<bool>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(locales().msgscene.leaveDialogTitle),
      content: Text(locales().msgscene.leaveDialogText),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(locales().msgscene.leave),
          onPressed: () => Navigator.pop(context, true)
        ),
        CupertinoDialogAction(
          child: Text(locales().msgscene.cancel),
          onPressed: () => Navigator.pop(context, false),
          isDestructiveAction: true
        )
      ],
    )
  );
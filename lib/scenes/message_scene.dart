import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/components/message_row.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/scenes/photo_detail_scene.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/components/member_detail_sheet.dart';

typedef ImageClickCallback (String messageId);
typedef ProfileClickCallback (String memberToken);

@immutable
class MessageScene extends StatefulWidget {

  MessageScene();

  @override
  _MessageSceneState createState() => _MessageSceneState();
}

class _MessageSceneState extends State<MessageScene> with WidgetsBindingObserver {
  bool _inited = false;
  AppState _model;
  String _inputedMessage;
  TextEditingController _messageInputFieldCtrl = TextEditingController();
  ScrollController _scrollController = ScrollController();

  String _generateTemporaryMessageId() =>
    "${DateTime.now().millisecondsSinceEpoch}";

  Future<void> _onImageSentClicked(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final model = ScopedModel.of<AppState>(context);
    String tempMessageId = _generateTemporaryMessageId();

    var imageContent = await model.uploadImage(
      image: image,
      tempMessageId: tempMessageId
    );
    model.publishMessage(
      content: imageContent,
      type: MessageType.IMAGE,
      previousMessageId: tempMessageId
    );
  }

  Future<void> _onMessageSend(BuildContext context) async {
    if (_inputedMessage == null || _inputedMessage.trim().length == 0) {
      await showSimpleAlert(context, locales().msgscene.messageEmpty);
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
    await model.translateMessages();
  }

  Future<void> _onRoomLeaveClicked(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    bool isLeave = await _showLeaveDialog(context);
    if (isLeave == true) {
      await model.leaveFromRoom(model.currentRoom.roomToken);
      Navigator.of(context).pop();
    }
  }

  Future<void> _onImageClicked(BuildContext context, String messageId) async {
    final model = ScopedModel.of<AppState>(context);
    await Navigator.of(context).push(CupertinoPageRoute<String>(
      title: 'Photo',
      builder: (BuildContext context) => 
        PhotoDetailScene(
          context,
          model.currentRoom.messages.messages,
          messageId
        )
    ));
  }

  Future<void> _onMemberBlockSelected(BuildContext context, String targetMember) async {
    print("block! $targetMember");
  }

  Future<void> _onMemberReportSelected(BuildContext context, String targetMember) async {
    print("report! $targetMember");
  }

  Future<void> _onProfileClicked(BuildContext context, String memberToken) async {
    await showMemberDetailSheet(context, 
      memberToken: memberToken,
      blockCallback: (String token) => _onMemberBlockSelected(context, token),
      reportCallback: (String token) => _onMemberReportSelected(context, token)
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _inited = false;
    _model.outFromRoom();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var func = () async {
      if (state == AppLifecycleState.resumed) {
        if (_model.currentRoom != null) {
          _model.currentRoom.messages.clearNotViewed();
          await _model.fetchMessagesWhenResume(roomToken: _model.currentRoom.roomToken);
          await _model.translateMessages();
        }
      }
    };
    func();
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
        middle: Text(room.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ), 
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
                    controller: _scrollController,
                    imageClickCallback: (String messageId) =>
                      _onImageClicked(context, messageId),
                    profileClickCallback: (String memberToken) =>
                      _onProfileClicked(context, memberToken)
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
  @required ScrollController controller,
  @required ImageClickCallback imageClickCallback,
  @required ProfileClickCallback profileClickCallback
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
      return MessageRow(
        message: msg,
        state: model,
        imageClickCallback: imageClickCallback,
        profileClickCallback: profileClickCallback,
      );
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
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/components/message_row.dart';
import 'package:chatpot_app/styles.dart';

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

  Future<void> _onMessageSend(BuildContext context) async {
    print(_inputedMessage);
  }

  Future<void> _onSceneShown(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    _model = model;
    MyRoom room = model.currentRoom;
    await model.fetchMoreMessages(roomToken: room.roomToken);
    print("ROOM MESSAGE FETCHED, room:${room.title}, size:${model.messages.length}");
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
        previousPageTitle: 'Chats',
        middle: Text(room.title), 
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text('Leave'),
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
                  child: _buildListView(context)
                ),
                _buildEditText(context, 
                  valueChanged: (String value) => setState(() => _inputedMessage = value),
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

Widget _buildListView(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: model.currentRoom.messages.messages.length,
    itemBuilder: (BuildContext context, int idx) {
      Message msg = model.currentRoom.messages.messages[idx];
      return MessageRow(message: msg, state: model);
    }
  );
}

Widget _buildEditText(BuildContext context, {
  @required ValueChanged<String> valueChanged,
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
          onPressed: () {

          }
        ),
        Expanded(
          child: CupertinoTextField(
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
      title: Text('Leaving room'),
      content: Text('Are you sure leaving from this room?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Leave'),
          onPressed: () => Navigator.pop(context, true)
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context, false),
          isDestructiveAction: true
        )
      ],
    )
  );
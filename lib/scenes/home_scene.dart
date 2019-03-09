import 'dart:async';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/room_row.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/scenes/more_chats_scene.dart';

@immutable
class HomeScene extends StatelessWidget implements EventReceivable {

  final BuildContext parentContext;

  HomeScene({
    this.parentContext
  });

  void _onChatRowSelected(BuildContext context, Room room) async {
    final model = ScopedModel.of<AppState>(context);
    bool isJoin = await _showJoinConfirm(context, room);
    if (isJoin == true) {
      var joinResp = await model.joinToRoom(room.roomToken);

      if (joinResp.success == true) {
        Toast.show('Successfully joined to room', context, duration: 2);
      } else {
        Toast.show("Failed to join the room: ${joinResp.cause}", context, duration: 2);
      }
    }
  }

  void _onMoreRoomsClicked(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        title: 'More chats',
        builder: (BuildContext context) => MoreChatsScene()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    List<Room> rooms = model.publicRooms;

    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Lounge')
      ),
      child: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: rooms.length + 2,
          itemBuilder: (BuildContext context, int idx) {
            if (idx == 0) return _buildSummaryView(context);
            if (idx == 1) return _buildRecentsHeader(context, () => _onMoreRoomsClicked(context));
            return RoomRow(
              room: rooms[idx - 2],
              rowClickCallback: (Room room) => _onChatRowSelected(context, room)
            );
          }
        )
      )
    );
  }

  @override
  Future<void> onSelected(BuildContext context) async {
    print('HOME_SCENE');
    final model = ScopedModel.of<AppState>(context);
    await model.fetchPublicRooms();
    print('HOME_SCENE_COMPLETED');
  }
}

Widget _buildSummaryView(BuildContext context) {
  return Container(
    height: 100
  );
}

Widget _buildRecentsHeader(BuildContext context, VoidCallback detailButtonCallback) {
  return Container(
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      border: Border(
        top: BorderSide(color: Styles.listRowDivider, width: 0.3),
        bottom:BorderSide(color: Styles.listRowDivider, width: 0.3)
      )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
          child: Text('Recent chats',
            style: TextStyle(
              fontSize: 13
            )
          )
        ),
        Container(
          child: CupertinoButton(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: Text('More chats ..',
              style: TextStyle(
                fontSize: 13
              ),
            ),
            onPressed: detailButtonCallback,
          )
        )
      ]
    )
  );
}

Future<bool> _showJoinConfirm(BuildContext context, Room room) {
  String content = "Title: ${room.title}\n\nDo you really want to enter the chat room?";
  return showCupertinoDialog<bool>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Join chat'),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Join'),
          onPressed: () => Navigator.pop(context, true),
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context, false),
          isDestructiveAction: true
        )
      ]
    )
  );
}

Future<void> _showJoinFailDialog(BuildContext context, String cause) async =>
  showCupertinoDialog<bool>(
    context: context,
    builder: (conext) => CupertinoAlertDialog(
      title: Text('Failed to join'),
      content: Text(cause),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Confirm'),
          onPressed: () => Navigator.of(context).pop()
        )
      ],
    )
  );
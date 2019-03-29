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
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/components/room_detail_card.dart';

@immutable
class HomeScene extends StatelessWidget implements EventReceivable {

  final BuildContext parentContext;

  HomeScene({
    this.parentContext
  });

  void _onChatRowSelected(BuildContext context, Room room) async {
    final model = ScopedModel.of<AppState>(context);
    bool isJoin = await _showCupertinoRoomDetailSheet(context, room);
    if (isJoin == true) {
      var joinResp = await model.joinToRoom(room.roomToken);

      if (joinResp.success == true) {
        Toast.show('Successfully joined to room', context, duration: 2);
      } else {
        Toast.show("Failed to join the room: ${joinResp.cause}", context, duration: 2);
      }
    }
  }

  void _onMoreRoomsClicked(BuildContext context, String type) {
    var order;
    if (type == 'crowded') order = RoomQueryOrder.ATTENDEE_DESC;
    if (type == 'recent') order =RoomQueryOrder.REGDATE_DESC;

    Navigator.of(context).push(
      CupertinoPageRoute(
        title: 'More chats',
        builder: (BuildContext context) =>
          MoreChatsScene(RoomSearchCondition(
            order: order
          ))
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var listItems = _buildListViewItems(context,
      moreRoom: (type) => _onMoreRoomsClicked(context, type),
      roomSelect: (r) => _onChatRowSelected(context, r)
    );

    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Lounge')
      ),
      child: SafeArea(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: listItems.length,
          itemBuilder: (BuildContext context, int idx) => listItems[idx]
        )
      )
    );
  }

  @override
  Future<void> onSelected(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    await model.fetchHomeSceneRooms();
  }
}

typedef MoreRoomCallback (String moreRoomType);
typedef RoomSelectCallback (Room room);

List<Widget> _buildListViewItems(BuildContext context, {
  @required MoreRoomCallback moreRoom,
  @required RoomSelectCallback roomSelect
}) {
  List<Widget> widgets = List();
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);

  widgets.add(_buildRoomsHeader(context,
    type: 'recent',
    title: 'Recent chats',
    detailButtonCallback: moreRoom
  ));
  var recentRoomRows = model.recentRooms.map((r) =>
    RoomRow(room: r, rowClickCallback: roomSelect)).toList();
  widgets.addAll(recentRoomRows);

  widgets.add(_buildRoomsHeader(context,
    type: 'crowded',
    title: 'Most crowded chats',
    detailButtonCallback: moreRoom
  ));
  var crowdedRoomRows = model.crowdedRooms.map((r) =>
    RoomRow(room: r, rowClickCallback: roomSelect)).toList();
  widgets.addAll(crowdedRoomRows);
  return widgets;
}

Widget _buildRoomsHeader(BuildContext context, {
  @required String type,
  @required String title,
  @required MoreRoomCallback detailButtonCallback
}) {
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
          child: Text(title,
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
            onPressed: () => detailButtonCallback(type),
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

Future<bool> _showRoomDetailSheet(BuildContext context, Room room) async {
  return await showModalBottomSheet<bool>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 170,
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RoomDetailCard(room: room)
          ]
        )
      );
    });
}

Future<bool> _showCupertinoRoomDetailSheet(BuildContext context, Room room) async {
  return await showCupertinoModalPopup<bool>(
    context: context,
    builder: (BuildContext context) =>
      CupertinoActionSheet(
        message: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoomDetailCard(room: room)
            ],
          )
        ),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Join'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Cancel'),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]
      )
  );
}
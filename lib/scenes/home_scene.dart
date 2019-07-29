import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/room_row.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/scenes/more_chats_scene.dart';
import 'package:chatpot_app/scenes/new_chat_scene.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/components/room_detail_sheet.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/scenes/message_scene.dart';

@immutable
class HomeScene extends StatelessWidget implements EventReceivable {

  final BuildContext parentContext;
  final TabActor actor;

  HomeScene({
    this.parentContext,
    this.actor
  });

  void _showMessageScene(BuildContext context, String roomToken) async {
    final model = ScopedModel.of<AppState>(context);
    List<MyRoom> rooms = model.myRooms.where((r) => r.roomToken == roomToken).toList();

    if (rooms.length > 0) {
      await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
        builder: (BuildContext context) => MessageScene(
          room: rooms[0]
        )
      ));
    }
  }

  void _onNewChatClicked(BuildContext context) async {
    String roomToken = await Navigator.of(parentContext).push(CupertinoPageRoute<String>(
      builder: (BuildContext context) => NewChatScene()
    ));
    if (roomToken == null) return;

    _showMessageScene(context, roomToken);
  }

  void _onChatRowSelected(BuildContext context, Room room) async {
    final model = ScopedModel.of<AppState>(context);
    bool isJoin = await showRoomDetailSheet(context, room);
    if (isJoin == true) {
      var joinResp = await model.joinToRoom(room.roomToken);

      if (joinResp.success == true) {
        await model.fetchMyRooms();
        _showMessageScene(context, room.roomToken);

      } else {
        String errorCode = joinResp.cause;
        if (errorCode == 'ROOM_ALREADY_JOINED') {
          _showMessageScene(context, room.roomToken);
        } else {
          await showSimpleAlert(context, locales().error.messageFromErrorCode(errorCode));
        }
      }
    }
  }

  void _onMoreRoomsClicked(BuildContext context, String type) async {
    RoomQueryOrder order;
    if (type == 'crowded') order = RoomQueryOrder.ATTENDEE_DESC;
    if (type == 'recent') order = RoomQueryOrder.REGDATE_DESC;

    String joinedRoomToken = await Navigator.of(parentContext).push<String>(
      CupertinoPageRoute<String>(
        title: 'More chats',
        builder: (BuildContext context) =>
          MoreChatsScene(
            condition: RoomSearchCondition(
              order: order
            )
          )
      )
    );

    if (joinedRoomToken != null) {
      final model = ScopedModel.of<AppState>(context);
      await model.fetchMyRooms();
      _showMessageScene(context, joinedRoomToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    var listItems = _buildListViewItems(context,
      moreRoom: (type) => _onMoreRoomsClicked(context, type),
      roomSelect: (r) => _onChatRowSelected(context, r)
    );

    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(start: 5, end: 5),
        backgroundColor: styles().navigationBarBackground,
        middle: Text(locales().home.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Icon(MdiIcons.plus,
            size: 27,
            color: styles().link,
          ),
          onPressed: () => _onNewChatClicked(context)
        ),
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
    await model.translatePublicRooms();
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
    title: locales().home.recentChatHeader,
    detailButtonCallback: moreRoom
  ));
  var recentRoomRows = model.recentRooms.map((r) =>
    RoomRow(room: r, rowClickCallback: roomSelect)).toList();
  widgets.addAll(recentRoomRows);

  widgets.add(_buildRoomsHeader(context,
    type: 'crowded',
    title: locales().home.crowdedChatHeader,
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
      color: styles().listRowHeaderBackground,
      border: Border(
        top: BorderSide(color: styles().listRowDivider, width: 0.3),
        bottom: BorderSide(color: styles().listRowDivider, width: 0.3)
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
              fontSize: 14,
              color: styles().primaryFontColor
            )
          )
        ),
        Container(
          child: CupertinoButton(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: Text(locales().home.moreChat,
              style: TextStyle(
                fontSize: 13,
                color: styles().link
              ),
            ),
            onPressed: () => detailButtonCallback(type),
          )
        )
      ]
    )
  );
}
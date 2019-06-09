import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/components/my_room_row.dart';
import 'package:chatpot_app/scenes/new_chat_scene.dart';
import 'package:chatpot_app/scenes/message_scene.dart';
import 'package:chatpot_app/factory.dart';

@immutable
class ChatsScene extends StatelessWidget implements EventReceivable {

  final BuildContext parentContext;
  final TabActor actor;

  ChatsScene({
    @required this.parentContext,
    @required this.actor
  });

  Future<void> _onNewChatClicked(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    String roomToken = await Navigator.of(parentContext).push(CupertinoPageRoute<String>(
      builder: (BuildContext context) => NewChatScene()
    ));
    if (roomToken == null) return;

    // if room was created, move to new room
    if (roomToken != null) {
      List<MyRoom> rooms = model.myRooms.where((elem) => elem.roomToken == roomToken).toList();
      if (rooms.length > 0) {
        MyRoom room = rooms[0];
        await model.selectRoom(room: room);
        Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
          title: room.title,
          builder: (BuildContext context) => MessageScene()
        ));
      }
    }
  }

  Future<void> _onMyRoomSelected(BuildContext context, MyRoom room) async {
    final model = ScopedModel.of<AppState>(context);
    await model.selectRoom(room: room);
    Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      title: room.title,
      builder: (BuildContext context) => MessageScene()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().chats.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Icon(MdiIcons.plus),
          onPressed: () => _onNewChatClicked(context)
        ),
      ),
      child: SafeArea(
        child: _buildMyRoomsView(context)
      )
    );
  }

  Future<void> onSelected(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    await model.fetchMyRooms();
    await model.translateMyRooms();
  }

  Widget _buildMyRoomsView(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    List<MyRoom> myRooms = model.myRooms;
    if (myRooms.length == 0 && model.loading == false) {
      return _buildEmptyRoomsView(context);
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: myRooms.length,
      itemBuilder: (BuildContext context, int idx) {
        MyRoom room = myRooms[idx];
        return MyRoomRow(
          myRoom: room,
          myRoomSelectCallback: (r) => _onMyRoomSelected(context, r)
        );
      }
    );
  }

  Widget _buildEmptyRoomsView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.battery_75_percent, // TODO: change icon
            size: 60.0,
            color: Styles.secondaryFontColor
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(locales().chats.emptyRooms,
            style: TextStyle(
              color: Styles.secondaryFontColor,
              fontSize: 15
            ),
            textAlign: TextAlign.center,
          )
        ]
      )
    );
  }
}
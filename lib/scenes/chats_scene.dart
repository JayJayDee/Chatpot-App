import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/components/my_room_row.dart';

class ChatsScene extends StatelessWidget implements EventReceivable {

  Future<void> _onNewChatClicked(BuildContext context) async {
    print('NEW CHAT CLICKED');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Chats'),
        trailing: CupertinoButton(
          child: Text('New chat'),
          onPressed: () => _onNewChatClicked(context)
        ),
      ),
      child: SafeArea(
        child: _buildMyRoomsView(context)
      )
    );
  }

  Future<void> onSelected(BuildContext context) async {
    print('CHATS_SCENE');
    final model = ScopedModel.of<AppState>(context);
    await model.fetchMyRooms();
  }

  Widget _buildMyRoomsView(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    List<MyRoom> myRooms = model.myRooms;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: myRooms.length,
      itemBuilder: (BuildContext context, int idx) {
        MyRoom room = myRooms[idx];
        return MyRoomRow(myRoom: room);
      }
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/room_row.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';

class HomeScene extends StatelessWidget implements EventReceivable {

  void _onChatRowSelected(Room room) {
    print(room);
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    List<Room> rooms = model.publicRooms;

    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home')
      ),
      child: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: rooms.length,
          itemBuilder: (BuildContext context, int idx) {
            return RoomRow(
              room: rooms[idx],
              rowClickCallback: () => _onChatRowSelected(rooms[idx])
            );
          },
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
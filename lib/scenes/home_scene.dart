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

  void _onRoomsDetailClicked() {

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
          itemCount: rooms.length + 1,
          itemBuilder: (BuildContext context, int idx) {
            if (idx == 0) return _buildRecentsHeader(_onRoomsDetailClicked);
            return RoomRow(
              room: rooms[idx - 1],
              rowClickCallback: () => _onChatRowSelected(rooms[idx - 1])
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

Widget _buildRecentsHeader(VoidCallback detailButtonCallback) {
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
            onPressed: () {
            },
          )
        )
      ]
    )
  );
}
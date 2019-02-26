import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/room.dart';

VoidCallback _rowClickCallback;
Room _room;

class RoomRow extends StatelessWidget {
  RoomRow({
    @required Room room,
    @required VoidCallback rowClickCallback
  }) {
    _rowClickCallback = rowClickCallback;
    _room = room;
  }

  @override
  Widget build(BuildContext context) {
    print(_room.title);
    return CupertinoButton(
      onPressed: _rowClickCallback,
      child: Text(_room.title)
    );
  }
}
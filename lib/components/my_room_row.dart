import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/room.dart';

typedef MyRoomCallback = Function(MyRoom);

@immutable
class MyRoomRow extends StatelessWidget {

  final MyRoom myRoom;
  final MyRoomCallback myRoomSelectCallback;

  MyRoomRow({
    this.myRoom,
    this.myRoomSelectCallback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Text('${myRoom.title}')
      ),
    );
  }
}
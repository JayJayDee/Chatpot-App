import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/entities/room.dart';

typedef LoadingChangeCallback (bool loading);
typedef MemberSelectCallback (String memberToken);

@immutable
class MessageInnerDrawer extends StatefulWidget {

  final MyRoom room;
  final MemberSelectCallback memberSelectCallback;
  final MemberInnerDrawerController controller;

  MessageInnerDrawer({
    @required this.room,
    @required this.memberSelectCallback,
    @required this.controller
  });

  @override
  State createState() => _MessageInnerDrawerState(
    room: room,
    memberSelectCallback: memberSelectCallback,
    controller: controller
  );
}

class MemberInnerDrawerController {
  VoidCallback _changeCallback;

  MemberInnerDrawerController();

  void notifyMemberChanged() {
    if (_changeCallback != null) {
      _changeCallback();
    }
  }

  void setChangeCallback(VoidCallback callback) {
    _changeCallback = callback;
  }
}

class _MessageInnerDrawerState extends State<MessageInnerDrawer> {

  final MyRoom room;
  final MemberSelectCallback memberSelectCallback;
  final MemberInnerDrawerController controller;

  RoomDetail roomDetail;

  _MessageInnerDrawerState({
    @required this.room,
    @required this.memberSelectCallback,
    @required this.controller
  });

  @override
  void initState() {
    super.initState();
    print('!');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: styles().innerDrawerBackground
    );
  }
}
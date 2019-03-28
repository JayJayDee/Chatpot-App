import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/factory.dart';

class RoomDetailCard extends StatefulWidget {

  final Room room;

  RoomDetailCard({
    this.room
  });

  _RoomDetailCard createState() => _RoomDetailCard(room);
}

class _RoomDetailCard extends State<RoomDetailCard> {

  Room _room;
  RoomDetail _detail;

  _RoomDetailCard(Room room) {
    _room = room;
  }

  Future<void> initDetailCard() async {
    var detail = await roomApi().requestRoomDetail(roomToken: _room.roomToken);
    setState(() {
      _detail = detail;
    });
  }

  @override
  void initState() {
    print('ROOM_DETAIL_INIT');
    initDetailCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_detail == null) {
      return Center(
        child: CupertinoActivityIndicator()
      );
    }
    return Center(
      child: Text('done!')
    );
  }

  List<Widget> _buildMemberListItems(List<Member> members) {
    return members.map((m) =>
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: CachedNetworkImage(
              imageUrl: m.avatar.thumb,
              placeholder: (context, url) => CupertinoActivityIndicator(),
              width: 50,
              height: 50
            )
          ),
          Positioned(
            child: Container(
              width: 24,
              height: 12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: localeConverter().getFlagImage(m.region),
                  fit: BoxFit.cover
                )
              )
            )
          )
        ]
      )
    ).toList();
  }
}
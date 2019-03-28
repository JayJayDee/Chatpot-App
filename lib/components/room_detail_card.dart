import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

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
      return Container(
        height: 170,
        decoration: BoxDecoration(
          border: BorderDirectional(bottom: BorderSide(
            width: 0.0,
            color: CupertinoColors.inactiveGray
          ))
        ),
        child: Center(
          child: CupertinoActivityIndicator()
        ),
      );
    }
    var memberListItems = _buildMemberListItems(_detail.members);
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(
          width: 0.0,
          color: CupertinoColors.inactiveGray
        ))
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(_detail.title,
            style: TextStyle(
              color: Styles.secondaryFontColor,
              fontSize: 16
            )
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: memberListItems.length,
              itemBuilder: (BuildContext context, int idx) => memberListItems[idx]
            )
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Text('Join room'),
                onPressed: () {},
              ),
              CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Text('Cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed
                  )
                ),
                onPressed: () {},
              )
            ]
          )
        ]
      )
    );
  }

  List<Widget> _buildMemberListItems(List<Member> members) {
    return members.map((m) =>
      Container(
        margin: EdgeInsets.only(left: 5),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: m.avatar.thumb,
                placeholder: (context, url) => Container(
                  width: 50,
                  height: 50,
                  child: CupertinoActivityIndicator()
                ),
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
      )
    ).toList();
  }
}
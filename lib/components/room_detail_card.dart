import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

typedef RoomSelectCallback (Room room);

class RoomDetailCard extends StatefulWidget {

  final Room room;
  final RoomSelectCallback roomSelected;

  RoomDetailCard({
    this.room,
    this.roomSelected
  });

  _RoomDetailCard createState() => _RoomDetailCard(
    room: room,
    callback: roomSelected
  );
}

class _RoomDetailCard extends State<RoomDetailCard> {

  Room _room;
  RoomDetail _detail;
  RoomSelectCallback _callback;

  _RoomDetailCard({
    @required Room room,
    @required RoomSelectCallback callback
  }) {
    _room = room;
    _callback = callback;
  }

  Future<void> initDetailCard() async {
    var detail = await roomApi().requestRoomDetail(roomToken: _room.roomToken);
    setState(() {
      _detail = detail;
    });
  }

  @override
  void initState() {
    initDetailCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_detail == null) {
      return Container(
        child: Center(
          child: CupertinoActivityIndicator()
        ),
      );
    }
    var memberListItems = _buildMemberListItems(_detail.members);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(_detail.title,
            style: TextStyle(
              color: Styles.secondaryFontColor,
              fontSize: 18,
              fontWeight: FontWeight.normal
            )
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          _buildTranslationRow(context, _room),
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
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            locales().toDateTime(_room.regDate),
            style: TextStyle(
              fontWeight: FontWeight.normal
            )
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(
            locales().room.numMembersInRoom(_detail.members),
            style: TextStyle(
              fontWeight: FontWeight.normal
            )
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
                    image: locales().getFlagImage(m.region),
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

Widget _buildTranslationRow(BuildContext context, Room room) { 
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  bool translationRequired = false;
  if (model.member.language != room.owner.language) translationRequired = true;

  if (translationRequired == false) {
    return Center();
  }

  Widget indicator;
  if (room.titleTranslated != null) {
    indicator = Text(room.titleTranslated,
      style: TextStyle(
        fontSize: 14,
        color: Styles.secondaryFontColor,
        fontWeight: FontWeight.normal
      ),
      textAlign: TextAlign.left,
    );
  } else {
    indicator = Container(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2
      )
    );
  }

  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(locales().room.translateLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Styles.secondaryFontColor
          )
        ),
        Padding(padding: EdgeInsets.only(left: 7)),
        Flexible(
          child: indicator
        )
      ],
    )
  );
}
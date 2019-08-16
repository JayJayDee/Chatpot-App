import 'package:chatpot_app/apis/api_entities.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';

typedef MyRoomCallback = Function(MyRoom);

class MyRouletteWaitingRow extends StatelessWidget {
  final RouletteStatus roulette;

  MyRouletteWaitingRow({
    @required this.roulette
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(left: 5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.accessibility_new,
                    color: styles().secondaryFontColor,
                    size: 40,
                  ),
                  SizedBox(
                    width: 58,
                    height: 58,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0
                    )
                  )
                ]
              )
            ),
            Expanded(
              child: Container()
            ),
            Icon(MdiIcons.chevronRight,
              color: styles().secondaryFontColor,
            )
          ]
        )
      )
    );
  }
}

@immutable
class MyRoomRow extends StatelessWidget {

  final MyRoom myRoom;
  final MyRoomCallback myRoomSelectCallback;
  final BuildContext parentContext;

  MyRoomRow({
    this.myRoom,
    this.myRoomSelectCallback,
    this.parentContext
  });

  void _onRowClicked() {
    this.myRoomSelectCallback(myRoom);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: _onRowClicked,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: CachedNetworkImage(
                        imageUrl: _getOwnerImage(myRoom)
                      )
                    )
                  ),
                  Positioned(
                    child: Container(
                      width: 30,
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: styles().primaryFontColor),
                        image: DecorationImage(
                          image: locales().getFlagImage(myRoom.owner.region),
                          fit: BoxFit.cover
                        )
                      ),
                    )
                  )
                ]
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    padding: EdgeInsets.only(left: 7),
                    child: Text(_fetchTitle(myRoom),
                      style: TextStyle(
                        fontSize: 15,
                        color: styles().primaryFontColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                  myRoom.type == RoomType.PUBLIC ? 
                    _buildTranslationRow(context, myRoom) :
                    Container(),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            color: styles().secondaryFontColor,
                            padding: EdgeInsets.all(3),
                            child: Text(locales().room.numMembersSimple(myRoom.numAttendee),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                              )
                            )
                          )
                        ),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Expanded(
                          child: Text(locales().room.myRoomRecentMessage(myRoom.lastMessage),
                            style: TextStyle(
                              fontSize: 14,
                              color: styles().secondaryFontColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5),
              child: Row(
                children: [
                  _getRoomBadge(myRoom),
                  Icon(MdiIcons.chevronRight,
                    color: styles().secondaryFontColor,
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}

String _fetchTitle(MyRoom room) {
  if (room.type == RoomType.PUBLIC) return room.title;
  return locales().chats.rouletteTitle(room.rouletteOpponent.nick);
}

String _getOwnerImage(MyRoom room) {
  if (room.type == RoomType.PUBLIC) return room.owner.avatar.thumb;
  return room.rouletteOpponent.avatar.thumb;
}

Widget _getRoomBadge(MyRoom room) {
  int notViewed = room.messages.notViewed;
  if (notViewed == 0) return Center();
  return Container(
    child: Text(
      "$notViewed",
      style: TextStyle(
        color: CupertinoColors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold
      )
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      color: CupertinoColors.destructiveRed
    ),
    padding: EdgeInsets.only(left: 7, top: 2, bottom: 2, right: 7)
  );
}

Widget _buildTranslationRow(BuildContext context, MyRoom room) { 
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  bool translationRequired = false;
  if (model.member.language != room.owner.language) translationRequired = true;

  if (translationRequired == false) {
    return Center();
  }

  Widget indicator;
  if (room.titleTranslated != null) {
    indicator = Expanded(
      child: Text(room.titleTranslated,
        style: TextStyle(
          fontSize: 14,
          color: styles().primaryFontColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis
      )
    );
  } else {
    indicator = Container(
      width: 13,
      height: 13,
      child: CircularProgressIndicator(
        strokeWidth: 2
      )
    );
  }

  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Text(locales().room.translateLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: styles().primaryFontColor
          )
        ),
        Padding(padding: EdgeInsets.only(left: 5)),
        indicator
      ],
    )
  );
}
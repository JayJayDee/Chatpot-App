import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

typedef MyRoomCallback = Function(MyRoom);

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
      height: 70,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: _onRowClicked,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10)
            ),
            Container(
              width: 60,
              height: 60,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CachedNetworkImage(
                      imageUrl: myRoom.owner.avatar.thumb,
                      placeholder: (context, url) => CupertinoActivityIndicator(),
                      width: 60,
                      height: 60,
                    )
                  ),
                  Positioned(
                    child: Container(
                      width: 30,
                      height: 15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _getFlagImage(myRoom.owner.region),
                          fit: BoxFit.cover
                        )
                      ),
                    )
                  )
                ],
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      myRoom.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF505050)
                      )
                    ),
                  )
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      locales().room.myRoomSubtitle(myRoom),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF929292)
                      )
                    ),
                  )
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      locales().room.myRoomRecentMessage(myRoom.lastMessage),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF929292)
                      )
                    ),
                  )
                )
              ]
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _getRoomBadge(myRoom),
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: IconTheme(
                          data: IconThemeData(color: Styles.secondaryFontColor),
                          child: Icon(MdiIcons.chevronRight)
                        ),
                      )
                    ]
                  )
                ]
              )
            )
          ],
        )
      )
    );
  }
}

AssetImage _getFlagImage(String regionCode) {
  String lowered = regionCode.toLowerCase();
  String path = "assets/$lowered.png";
  return AssetImage(path);
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
      borderRadius: BorderRadius.all(Radius.circular(12)),
      color: CupertinoColors.destructiveRed
    ),
    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10)
  );
}
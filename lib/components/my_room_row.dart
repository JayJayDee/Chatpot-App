import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/entities/message.dart';

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
                      localeConverter().myRoomSubtitle(myRoom),
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
                      _getLastMessageExpression(myRoom.lastMessage),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: IconTheme(
                      data: IconThemeData(color: Styles.secondaryFontColor),
                      child: Icon(MdiIcons.chevronRight)
                    )
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

String _getLastMessageExpression(Message message) {
  String nick = localeConverter().getNick(message.from.nick);
  return "$nick: ${message.getTextContent()}";
}
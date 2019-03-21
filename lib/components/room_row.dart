import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

typedef RoomCallback = Function(Room);

@immutable
class RoomRow extends StatelessWidget {

  final RoomCallback rowClickCallback;
  final Room room;

  RoomRow({
    this.room,
    this.rowClickCallback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: CupertinoButton(
        onPressed: () => rowClickCallback(room),
        padding: EdgeInsets.all(0),
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
                      imageUrl: room.owner.avatar.thumb,
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
                          image: localeConverter().getFlagImage(room.owner.region),
                          fit: BoxFit.cover
                        )
                      ),
                    )
                  )
                ],
              )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      room.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF505050)
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      localeConverter().roomSubtitle(room),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF929292)
                      )
                    ),
                  )
                ]
              ),
            ),
            Column(
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
          ],
        )
      )
    );
  }
}
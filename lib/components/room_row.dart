import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/factory.dart';

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
                        image: _getFlagImage(room.owner.region),
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
                    room.title,
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
                    _subTitle(room),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF929292)
                    )
                  ),
                )
              ),
            ]
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: CupertinoButton(
                    child: Icon(CupertinoIcons.plus_circled),
                    onPressed: () => rowClickCallback(room)
                  )
                )
              ]
            )
          )
        ],
      )
    );
  }
}

AssetImage _getFlagImage(String regionCode) {
  String lowered = regionCode.toLowerCase();
  String path = "assets/$lowered.png";
  return AssetImage(path);
}

String _subTitle(Room room) {
  String nick = localeConverter().getNick(room.owner.nick);
  int others = room.numAttendee - 1;
  if (others == 0) return "$nick alone";
  return "$nick and $others others";
}
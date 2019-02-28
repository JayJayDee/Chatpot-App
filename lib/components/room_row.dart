import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:cached_network_image/cached_network_image.dart';

VoidCallback _rowClickCallback;
Room _room;

class RoomRow extends StatelessWidget {

  RoomRow({
    @required Room room,
    @required VoidCallback rowClickCallback
  }) {
    _rowClickCallback = rowClickCallback;
    _room = room;
  }

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
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl: _room.owner.avatar.thumb,
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    width: 60,
                    height: 60,
                  )
                ),
                Positioned(
                  left: 34,
                  top: 47,
                  child: Container(
                    width: 26,
                    height: 13,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _getFlagImage(_room.owner.region),
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
                    _room.title,
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
                    'Ms. Disgusting Banana and 3 others',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF929292)
                    )
                  ),
                )
              ),
            ],
          )
        ]
      )
    );
  }
}

AssetImage _getFlagImage(String regionCode) {
  String lowered = regionCode.toLowerCase();
  String path = "assets/$lowered.png";
  return AssetImage(path);
}
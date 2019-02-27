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
          Container(
            width: 60,
            height: 60,
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: _room.owner.avatar.thumb,
                  placeholder: (context, url) => CupertinoActivityIndicator()
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
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(_room.title),
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
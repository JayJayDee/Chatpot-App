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
            child: CachedNetworkImage(
              imageUrl: _room.owner.avatar.thumb,
              placeholder: (context, url) => CupertinoActivityIndicator()
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

Image _getFlagImage(String regionCode) {
  String lowered = regionCode.toLowerCase();
  String path = "assets/flags/$lowered.png";
  print(path);
  return Image.asset(path);
}
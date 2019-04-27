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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 60,
                  height: 60,
                  child: CachedNetworkImage(
                    imageUrl: myRoom.owner.avatar.thumb
                  )
                )
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('asdfjaskldjfklasjdfkljaksdfhajshdfaksdfja',
                      style: TextStyle(
                        fontSize: 15,
                        color: Styles.primaryFontColor
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                    )
                  )
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Icon(MdiIcons.chevronRight)
            )
          ]
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

Widget _buildTranslationRow(BuildContext context, MyRoom room) { 
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
        color: Styles.primaryFontColor
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
            color: Styles.primaryFontColor
          )
        ),
        Padding(padding: EdgeInsets.only(left: 5)),
        indicator
      ],
    )
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
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
                        border: Border.all(color: Styles.primaryFontColor),
                        image: DecorationImage(
                          image: locales().getFlagImage(room.owner.region),
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
                  _buildTranslationRow(context, room),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      locales().room.roomSubtitle(room),
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

Widget _buildTranslationRow(BuildContext context, Room room) { 
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  bool translationRequired = false;
  if (model.member.language != room.owner.language) translationRequired = true;

  if (translationRequired == false) {
    return Center();
  }

  Widget indicator;
  if (room.titleTranslated != null) {
    indicator = Flexible(
      child: Text(room.titleTranslated,
        style: TextStyle(
          fontSize: 14,
          color: Styles.primaryFontColor
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1
      )
    );
  } else {
    indicator = Container(
      width: 12,
      height: 12,
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
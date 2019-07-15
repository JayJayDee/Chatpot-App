import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

Widget buildProfileCard(BuildContext context, {
  bool editButton = false,
  VoidCallback editCallback
}) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (editButton == null) editButton = false;
  return Container(
    margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
    padding: EdgeInsets.only(top: 10, left: 10, right: 5, bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: styles().profileCardBackground,
    ),
    child: Row(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: model.member.avatar.thumb,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                )
              ),
              Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: styles().primaryFontColor),
                  image: DecorationImage(
                    image: locales().getFlagImage(model.member.region),
                    fit: BoxFit.cover
                  )
                )
              )
            ]
          )
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            height: 100,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Text(locales().getNick(model.member.nick),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: styles().primaryFontColor
                        )
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 5),
                      child: Text(model.member.regionName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          color: styles().secondaryFontColor
                        )
                      )
                    )
                  ]
                ),
                editButton == true ? Positioned(
                  child: CupertinoButton(
                    child: Icon(MdiIcons.settings,
                      color: styles().link,
                    ),
                    onPressed: () => editCallback()
                  )
                ) : Container()
              ]
            )
          )
        )
      ]
    )
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  String nick;
  if (model.member != null) nick = locales().getNick(model.member.nick);
  return Container(
    padding: EdgeInsets.all(10),
    child: Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
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
                          border: Border.all(color: Styles.primaryFontColor),
                          image: DecorationImage(
                            image: _getFlagImage(model.member.region),
                            fit: BoxFit.cover
                          )
                        )
                      )
                    ],
                  )
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(nick, 
                          style: TextStyle(
                            fontSize: 20,
                            color: Styles.primaryFontColor
                          )
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(model.member.regionName,
                          style: TextStyle(
                            fontSize: 13,
                            color: Styles.secondaryFontColor
                          )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        _buildEditButton(context, editButton, editCallback)
                      ],
                    )
                  )
                )
              ],
            )
          ],
        ),
      )
    )
  );
}

Widget _buildEditButton(BuildContext context, bool isEditShow, VoidCallback callback) {
  if (isEditShow == false) return Center();
  return CupertinoButton(
    child: Text('Edit my profile',
      style: TextStyle(
        fontSize: 15
      )
    ),
    padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
    onPressed: callback,
  );
}

AssetImage _getFlagImage(String regionCode) {
  String lowered = regionCode.toLowerCase();
  String path = "assets/$lowered.png";
  return AssetImage(path);
}
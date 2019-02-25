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
  if (model.member != null) nick = localeConverter().getNick(model.member.nick);
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: CachedNetworkImage(
                    imageUrl: model.member.avatar.thumb,
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(nick, textScaleFactor: 1.5),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text('South Korea, Republic of',
                      textScaleFactor: 1.0,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    _buildEditButton(context, editButton, editCallback)
                  ],
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
    child: Text('Edit my profile', style: Styles.cardActionTextStyle),
    color: CupertinoColors.activeBlue,
    onPressed: callback,
  );
}
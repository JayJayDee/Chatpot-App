import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

class SettingsScene extends StatelessWidget {

  void _onEditProfileClicked() async {

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings')
      ),
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildProfileCard(context, _onEditProfileClicked)
                ],
              )
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border(
                  top: BorderSide(color: Color(0xFFBCBBC1), width: 0.1),
                  bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.1)
                ),
              ),
              child: CupertinoButton(
                child: Text('Sign out'),
                onPressed: () {

                }
              ),
            )
          ],
        ),
      )
    );
  }
}

Widget _buildProfileCard(BuildContext context, VoidCallback callback) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  String nick;
  if (model.member != null) nick = localeConverter().getNick(model.member.nick);
  return Card(
    child: Container(
      padding: EdgeInsets.all(20),
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
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/placeholder-profile.png')
                  )
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
                  CupertinoButton(
                    child: Text('Edit my profile', style: Styles.cardActionTextStyle),
                    color: CupertinoColors.activeBlue,
                    onPressed: callback,
                  )
                ],
              )
            ],
          )
        ],
      ),
    )
  );
}
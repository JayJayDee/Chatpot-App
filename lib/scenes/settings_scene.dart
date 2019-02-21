import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';

class SettingsScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                  _buildProfileCard(context)
                ],
              )
            )
          ],
        ),
      )
    );
  }
}

Widget _buildProfileCard(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  String nick;
  if (model.member != null) nick = localeConverter().getNick(model.member.nick);
  return Card(
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Hello, $nick!", textScaleFactor: 1.5)
        ],
      ),
    )
  );
}
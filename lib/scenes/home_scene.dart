import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';

class HomeScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.appBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home')
      ),
      child: SafeArea(
        child: ListView(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: _buildProfileCard(context)
              )
            ]
          )
        ])
      )
    );
  }
}

Widget _buildProfileCard(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  String nick;
  if (model.member != null) {
    nick = model.member.nick.en;
  }
  return Card(
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Hello, $nick!", textScaleFactor: 1.5)
        ],
      ),
    )
  );
}
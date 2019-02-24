import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/profile_card.dart';

class SettingsScene extends StatelessWidget {

  void _onEditProfileClicked() async {

  }

  void _onSignoutClicked() async {

  }

  void _onAboutClicked() async {

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
            buildProfileCard(context, editButton: false, editCallback: _onEditProfileClicked),
            Padding(padding: EdgeInsets.only(top: 20)),
            _buildMenuItem('Sign out', _onSignoutClicked),
            _buildMenuItem('About Chatpot..', _onAboutClicked),
          ],
        ),
      )
    );
  }
}

Widget _buildMenuItem(String title, VoidCallback pressedCallback) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      border: Border(
        top: BorderSide(color: Color(0xFFBCBBC1), width: 0.3),
        bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.3)
      ),
    ),
    child: CupertinoButton(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title),
      ),
      onPressed: pressedCallback
    ),
  );
}
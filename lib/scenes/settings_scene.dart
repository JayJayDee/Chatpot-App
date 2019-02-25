import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/profile_card.dart';
import 'package:chatpot_app/components/not_login_card.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/member.dart';

BuildContext _parent;

class SettingsScene extends StatelessWidget {
  
  SettingsScene(BuildContext parent) {
    _parent = parent;
  }

  void _onEditProfileClicked() async {

  }

  void _onSignoutClicked(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    bool isSimple = model.member.authType == AuthType.SIMPLE;
    var resp = await _showSignoutWarningDialog(context, isSimple);

    if (resp == 'SIGNOUT') {
      model.signout();
    }
  }

  void _onSigninClicked(BuildContext context) async {
    print('sign-in');
    Navigator.of(_parent).pushReplacementNamed('/login');
  }

  void _onAboutClicked() async {

  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context);
    var elems;

    if (model.member == null) {
      elems = <Widget>[
        buildNotLoginCard(context, loginSelectCallback: () => _onSigninClicked(context)),
        _buildMenuItem('Sign in', () => _onSigninClicked(context)),
        _buildMenuItem('About Chatpot..', _onAboutClicked)
      ];
    } else {
      elems = <Widget> [
        buildProfileCard(context, editButton: true, editCallback: _onEditProfileClicked),
        _buildMenuItem('Sign out', () => _onSignoutClicked(context)),
        _buildMenuItem('About Chatpot..', _onAboutClicked)
      ];
    }

    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings')
      ),
      child: SafeArea(
        child: ListView(
          children: elems
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

Future<dynamic> _showSignoutWarningDialog(BuildContext context, bool isSimple) {
  String content = '';
  if (isSimple == true) {
    content = "You are now logged in as SIMPLE type.\n" + 
    "If you log in this way, your account information will be lost when you sign out.\n" +
    "To prevent this, you can link your mail account.\n"
    "Are you sure you want to sign out?";
  } else {
    content = 'Are you sure you want to sign out?';
  }
  return showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Sign out'),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Sign out'),
          onPressed: () => Navigator.pop(context, 'SIGNOUT')
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
          isDefaultAction: true,
          isDestructiveAction: true,
        )
      ]
    )
  );
}
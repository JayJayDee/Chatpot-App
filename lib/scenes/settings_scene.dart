import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/profile_card.dart';
import 'package:chatpot_app/components/not_login_card.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/scenes/login_scene.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/factory.dart';

@immutable
class SettingsScene extends StatelessWidget implements EventReceivable {

  final BuildContext parentContext;

  SettingsScene({
    this.parentContext
  });
  
  void _onEditProfileClicked() async {

  }

  void _onSignoutClicked(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    bool isSimple = model.member.authType == AuthType.SIMPLE;
    var resp = await _showSignoutWarningDialog(context, isSimple);

    if (resp == 'SIGNOUT') {
      await model.signout();
      Navigator.of(parentContext).pushReplacement(CupertinoPageRoute<bool>(
        builder: (BuildContext context) => LoginScene()
      ));
    }
  }

  void _onSigninClicked(BuildContext context) async {
    await Navigator.of(context).push(CupertinoPageRoute<bool>(
      title: 'Sign in',
      builder: (BuildContext context) => LoginScene()
    ));
  }

  void _onAboutClicked() async {

  }

  void _onDonationClicked() async {

  }

  @override
  Future<void> onSelected(BuildContext context) async {
    print('SETTINGS_SCENE');
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    var elems;

    if (model.member == null) {
      elems = <Widget>[
        buildNotLoginCard(context, loginSelectCallback: () => _onSigninClicked(context)),
        _buildMenuItem(locales().setting.signin, () => _onSigninClicked(context)),
        _buildMenuItem(locales().setting.about, _onAboutClicked),
        _buildMenuItem(locales().setting.donation, _onDonationClicked)
      ];
    } else {
      elems = <Widget> [
        buildProfileCard(context, editButton: true, editCallback: _onEditProfileClicked),
        _buildMenuItem(locales().setting.signout, () => _onSignoutClicked(context)),
        _buildMenuItem(locales().setting.about, _onAboutClicked),
        _buildMenuItem(locales().setting.donation, _onDonationClicked)
      ];
    }

    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().setting.title)
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
        child: Text(title,
          style: TextStyle(
            fontSize: 16
          )
        ),
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
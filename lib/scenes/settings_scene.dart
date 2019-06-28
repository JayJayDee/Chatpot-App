import 'dart:async';
import 'package:meta/meta.dart';
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
import 'package:chatpot_app/scenes/email_upgrade_scene.dart';
import 'package:chatpot_app/scenes/password_change_scene.dart';
import 'package:chatpot_app/scenes/about_scene.dart';
import 'package:chatpot_app/scenes/report_history_scene.dart';
import 'package:chatpot_app/scenes/block_history_scene.dart';

@immutable
class SettingsScene extends StatelessWidget implements EventReceivable {

  final BuildContext parentContext;
  final TabActor actor;

  SettingsScene({
    @required this.parentContext,
    @required this.actor
  });
  
  void _onEditProfileClicked() async {

  }

  void _onPasswordChangeClicked(BuildContext context) async {
    await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => PasswordChangeScene()
    ));
  }

  void _onSignoutClicked(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    bool isSimple = model.member.authType == AuthType.SIMPLE;
    var resp = await _showSignoutWarningDialog(context, isSimple);

    if (resp == 'SIGNOUT') {
      await model.unregisterDevice();
      await model.signout();

      final PageRouteBuilder loginRoute = new PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return LoginScene();
        }, 
      );

      Navigator.of(parentContext)
        .pushAndRemoveUntil(loginRoute, (Route<dynamic> r) => false);
    }
  }

  void _onSigninClicked(BuildContext context) async {
    await Navigator.of(context).push(CupertinoPageRoute<bool>(
      title: 'Sign in',
      builder: (BuildContext context) => LoginScene()
    ));
  }

  void _onAboutClicked(BuildContext context) async {
    await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => AboutScene()
    ));
  }

  void _onEmailAccountClicked(BuildContext context) async {
    final state = ScopedModel.of<AppState>(context);

    await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) =>
        EmailUpgradeScene(memberToken: state.member.token)
    ));
  }

  void _onMyReportsClicked(BuildContext context) async {
    await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => ReportHistoryScene()
    ));
  }

  void _onMyBlocksClicked(BuildContext context) async {
    await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => BlockHistoryScene()
    ));
  }

  @override
  Future<void> onSelected(BuildContext context) async {
    print('SETTINGS_SCENE');
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    List<Widget> elems;

    if (model.member == null) {
      elems = <Widget>[
        buildNotLoginCard(context, loginSelectCallback: () => _onSigninClicked(context)),
        _buildMenuItem(locales().setting.signin, () => _onSigninClicked(context)),
      ];
    } else {
      elems = <Widget> [
        buildProfileCard(context, editButton: false, editCallback: _onEditProfileClicked),
        _buildMenuItem(locales().setting.signout, () => _onSignoutClicked(context)),
      ];
    }

    if (model.member != null && model.member.authType == AuthType.SIMPLE) {
      elems.add(_buildMenuItem(locales().setting.linkMail, () => _onEmailAccountClicked(context) ));
    }

    if (model.member != null && model.member.authType == AuthType.EMAIL) {
      elems.add(_buildEmailLoggedInItem(model.member.loginId));
      elems.add(_buildMenuItem(locales().setting.changePassword, () => _onPasswordChangeClicked(context)));
    }

    elems.add(_buildMenuItem(locales().setting.myBlocks, () => _onMyBlocksClicked(context)));
    elems.add(_buildMenuItem(locales().setting.myReports, () => _onMyReportsClicked(context)));
    elems.add(_buildMenuItem(locales().setting.about, () => _onAboutClicked(context)));

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

Widget _buildEmailLoggedInItem(String email) {
  return Container(
    padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      border: Border(
        top: BorderSide(color: Color(0xFFBCBBC1), width: 0.3),
        bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.3)
      ),
    ),
    child: Text(locales().setting.loggedIn(email),
      style: TextStyle(
        color: Styles.secondaryFontColor
      )
    )
  );
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
    content = locales().setting.simpleSignoutWarning;
  } else {
    content = locales().setting.signoutWarning;
  }
  return showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(locales().setting.signout),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(locales().setting.signout),
          onPressed: () => Navigator.pop(context, 'SIGNOUT')
        ),
        CupertinoDialogAction(
          child: Text(locales().setting.cancel),
          onPressed: () => Navigator.pop(context),
          isDefaultAction: true,
          isDestructiveAction: true,
        )
      ]
    )
  );
}
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:oktoast/oktoast.dart';
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
import 'package:chatpot_app/scenes/profile_edit_scene.dart';

class SettingsScene extends StatefulWidget implements EventReceivable {
  final BuildContext parentContext;
  final TabActor actor;

  SettingsScene({
    @required this.parentContext,
    @required this.actor
  });

  @override
  State createState() => _SettingsSceneState(
    parentContext: parentContext,
    actor: actor
  );

  @override
  Future<void> onSelected(BuildContext context) async {
    print('SETTINGS_SCENE');
  }
}

class _SettingsSceneState extends State<SettingsScene> {

  BuildContext parentContext;
  TabActor actor;
  bool _darkMode;
  String _version;

  _SettingsSceneState({
    @required BuildContext parentContext,
    @required TabActor actor
  }) {
    this.parentContext = parentContext;
    this.actor = actor;
    this._version = '...';
    _darkMode =
      getStyleType() == StyleType.DARK ? true : false;
  }

  @override
  void initState() {
    super.initState();
    _fetchVersionInfo();
  }

  void _fetchVersionInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => _version = "${info.version}+${info.buildNumber}");
  }
  
  void _onEditProfileClicked() async {
    await Navigator.of(parentContext).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => ProfileEditScene()
    ));
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

  void _onSwitchChanged(BuildContext context, bool darkMode) async {
    final state = ScopedModel.of<AppState>(context);
    setState(() => _darkMode = darkMode);

    if (darkMode == true) {
      await state.changeStyleType(StyleType.DARK);
    } else {
      await state.changeStyleType(StyleType.LIGHT);
    }

    showToast(locales().setting.modeChangedDescription, 
      duration: Duration(milliseconds: 1500),
      position: ToastPosition(align: Alignment.bottomCenter)
    );
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
        buildProfileCard(context, editButton: true, editCallback: _onEditProfileClicked),
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

    elems.add(_buildThemeMenuItem(context,
      darkMode: _darkMode,
      callback: (bool darkMode) => _onSwitchChanged(context, darkMode)
    ));
    elems.add(_buildMenuItem(locales().setting.myBlocks, () => _onMyBlocksClicked(context)));
    elems.add(_buildMenuItem(locales().setting.myReports, () => _onMyReportsClicked(context)));
    elems.add(_buildMenuItem(locales().setting.about, () => _onAboutClicked(context)));
    elems.add(_buildVersionItem(version: _version));

    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        middle: Text(locales().setting.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        )
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
      color: styles().listViewRowBackgroundMoreDark,
      border: Border(
        top: BorderSide(color: Color(0xFFBCBBC1), width: 0.3),
        bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.3)
      ),
    ),
    child: Text(locales().setting.loggedIn(email),
      style: TextStyle(
        color: styles().secondaryFontColor
      )
    )
  );
}

typedef SwitchChangeCallback (bool darkMode);

Widget _buildThemeMenuItem(BuildContext context, {
  @required bool darkMode,
  @required SwitchChangeCallback callback
}) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 14, top: 6, bottom: 6),
    decoration: BoxDecoration(
      color: styles().listViewRowBackgroundMoreDark,
      border: Border(
        top: BorderSide(color: Color(0xFFBCBBC1), width: 0.3),
        bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.3)
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(locales().setting.darkMode,
            style: TextStyle(
              fontSize: 16,
              color: styles().secondaryFontColor
            )
          )
        ),
        CupertinoSwitch(
          value: darkMode,
          onChanged: callback
        )
      ]
    )
  );
}

Widget _buildMenuItem(String title, VoidCallback pressedCallback) {
  return Container(
    decoration: BoxDecoration(
      color: styles().listViewRowBackgroundMoreDark,
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
            fontSize: 16,
            color: styles().link
          )
        ),
      ),
      onPressed: pressedCallback
    ),
  );
}

Widget _buildVersionItem({
  @required String version
}) =>
  Container(
    padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
    decoration: BoxDecoration(
      color: styles().listViewRowBackgroundMoreDark,
      border: Border(
        top: BorderSide(color: Color(0xFFBCBBC1), width: 0.3),
        bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.3)
      ),
    ),
    child: Text(locales().setting.currentVersion(version),
      style: TextStyle(
        color: styles().secondaryFontColor
      )
    )
  );

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
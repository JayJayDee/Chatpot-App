import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

class PasswordChangeScene extends StatefulWidget {

  @override
  State createState() => _PasswordChangeSceneState();
}

class _PasswordChangeSceneState extends State<PasswordChangeScene> {
  
  String _oldPassword = '';
  String _newPassword = '';
  String _newPasswordConfirm = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().passwordChange.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Text(locales().passwordChange.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Styles.primaryFontColor
                    )
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: _buildOldPasswordField(context,
                    callback: (String text) => setState(() => _oldPassword = text)
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: _buildNewPasswordField(context,
                    callback: (String text) => setState(() => _newPassword = text)
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: _buildNewPasswordConfirmField(context,
                    callback: (String text) => setState(() => _newPasswordConfirm = text)
                  )
                )
              ]
            ),
            _buildProgress(context)
          ]
        )
      )
    );
  }
}

typedef TextChangedCallback (String inputed);

Widget _buildOldPasswordField(BuildContext context, {
  @required TextChangedCallback callback
}) {
  return CupertinoTextField(
    prefix: Icon(CupertinoIcons.padlock_solid,
      size: 28.0,
      color: CupertinoColors.inactiveGray),
    placeholder: locales().passwordChange.oldPasswordPlaceholder,
    onChanged: callback,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    obscureText: true,
    keyboardType: TextInputType.text,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
    )
  );
}

Widget _buildNewPasswordField(BuildContext context, {
  @required TextChangedCallback callback
}) {
  return CupertinoTextField(
    prefix: Icon(CupertinoIcons.padlock_solid,
      size: 28.0,
      color: CupertinoColors.inactiveGray),
    placeholder: locales().passwordChange.newPasswordPlaceholder,
    onChanged: callback,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    obscureText: true,
    keyboardType: TextInputType.text,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
    )
  );
}

Widget _buildNewPasswordConfirmField(BuildContext context, {
  @required TextChangedCallback callback
}) {
  return CupertinoTextField(
    prefix: Icon(CupertinoIcons.padlock_solid,
      size: 28.0,
      color: CupertinoColors.inactiveGray),
    placeholder: locales().passwordChange.newPasswordConfirmPlaceholder,
    onChanged: callback,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    obscureText: true,
    keyboardType: TextInputType.text,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
    )
  );
}

Widget _buildProgress(BuildContext context) {
  return Container();
}
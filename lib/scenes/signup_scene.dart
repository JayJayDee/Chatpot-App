import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:toast/toast.dart';

class SignupScene extends StatefulWidget {
  @override
  State createState() => _SignupSceneState();
}

class _SignupSceneState extends State<SignupScene> {

  String _email = '';
  String _password = '';
  String _passwordConfirm = '';

  Future<void> _onSignUpClicked() async {
    if (_email.trim().length == 0) {
      Toast.show(locales().signupScene.emailRequired, context, duration: 2);
    }
    if (_password.trim().length == 0) {
      Toast.show(locales().signupScene.passwordRequired, context, duration: 2);
    }
    if (_passwordConfirm.trim().compareTo(_password.trim()) != 0) {
      Toast.show(locales().signupScene.passwordNotMatch, context, duration: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().signupScene.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(locales().signupScene.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Styles.primaryFontColor
                )
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: _buildEmailField(context, 
                changedCallback: (String text) => 
                  setState(() => _email = text))
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: _buildPasswordField(context, 
                changedCallback: (String text) =>
                  setState(() => _password = text))
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: _buildPasswordConfirmField(context, 
                changedCallback: (String text) =>
                  setState(() => _passwordConfirm = text))
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: CupertinoButton(
                child: Text(locales().signupScene.joinButton),
                color: CupertinoColors.activeBlue,
                onPressed: () => _onSignUpClicked()
              )
            )
          ]
        )
      )
    );
  }
}

typedef TextChangedCallback (String text);

Widget _buildEmailField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) =>
  CupertinoTextField(
    prefix: Icon(CupertinoIcons.mail_solid,
      size: 28.0,
      color: CupertinoColors.inactiveGray),
    placeholder: locales().signupScene.emailPlaceHolder,
    onChanged: changedCallback,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
    )
  );

Widget _buildPasswordField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) =>
  CupertinoTextField(
    prefix: Icon(CupertinoIcons.padlock_solid,
      size: 28.0,
      color: CupertinoColors.inactiveGray),
    placeholder: locales().signupScene.passwordPlaceHolder,
    onChanged: changedCallback,
    obscureText: true,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
    )
  );

Widget _buildPasswordConfirmField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) =>
  CupertinoTextField(
    prefix: Icon(CupertinoIcons.mail_solid,
      size: 28.0,
      color: CupertinoColors.inactiveGray),
    placeholder: locales().signupScene.passworConfirmPlaceHolder,
    onChanged: changedCallback,
    obscureText: true,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
    )
  );
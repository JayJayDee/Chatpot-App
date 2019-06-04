import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/scenes/signup_simple_scene.dart';
import 'package:chatpot_app/scenes/signup_scene.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

String _email = '';
String _password = '';

class LoginScene extends StatelessWidget {

  Future<void> _onLoginSubmit(BuildContext context) async {
    if (_email.trim().length == 0) {
      await showSimpleAlert(context, 'Email requied'); // TODO: locale
      return;
    }
    if (_password.trim().length == 0) {
      await showSimpleAlert(context, 'Password required'); // TODO: locale
      return;
    }
  }

  void _onSimpleSignUp(BuildContext context) async {
    var resp = await Navigator.of(context).push(CupertinoPageRoute<bool>(
      title: 'Start without sign up', // TODO: locale
      builder: (BuildContext context) => SimpleSignupScene()
    ));
    if (resp == true) Navigator.pop(context, true);
  }

  void _onEmailSignup(BuildContext context) async {
    bool resp = await Navigator.of(context).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => SignupScene()
    ));
    if (resp == true) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().login.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: 500,
                child: ListView(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  children: <Widget>[
                    Text(locales().login.loginIntroduce,
                      style: TextStyle(
                        fontSize: 17,
                        color: Styles.primaryFontColor
                      )
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    _buildLoginField(context, (String value) => _email = value),
                    _buildPasswordField(context, (String value) => _password = value),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: CupertinoButton(
                        child: Text(locales().login.signInButton),
                        color: CupertinoColors.activeBlue,
                        onPressed: () => _onLoginSubmit(context)
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: CupertinoButton(
                        child: Text(locales().login.simpleSignupButton),
                        color: CupertinoColors.activeGreen,
                        onPressed: () => _onSimpleSignUp(context)
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: CupertinoButton(
                        child: Text(locales().login.signupButton),
                        onPressed: () => _onEmailSignup(context)
                      )
                    )
                  ],
                )
              )
            )
          ],
        ),
      )
    );  
  }
}

Widget _buildLoginField(BuildContext context, ValueChanged<String> valueChange) => CupertinoTextField(
  prefix: Icon(
    CupertinoIcons.mail_solid,
    color: CupertinoColors.lightBackgroundGray,
    size: 28.0
  ),
  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
  placeholder: locales().login.emailHint,
  keyboardType: TextInputType.emailAddress,
  decoration: BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
  ),
  onChanged: valueChange,
);

Widget _buildPasswordField(BuildContext context, ValueChanged<String> valueChange) => CupertinoTextField(
  prefix: Icon(
    CupertinoIcons.person_solid,
    color: CupertinoColors.lightBackgroundGray,
    size: 28.0
  ),
  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
  placeholder: locales().login.passwordHint,
  keyboardType: TextInputType.text,
  obscureText: true,
  decoration: BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
  ),
  onChanged: valueChange
);
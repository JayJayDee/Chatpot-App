import 'dart:async';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/scenes/signup_simple_scene.dart';
import 'package:chatpot_app/scenes/signup_scene.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/scenes/email_upgrade_scene.dart';
import 'package:chatpot_app/models/app_state.dart';

String _email = '';
String _password = '';

class LoginScene extends StatelessWidget {

  Future<void> _onLoginSubmit(BuildContext context) async {
    if (_email.trim().length == 0) {
      await showSimpleAlert(context, locales().login.emailRequired);
      return;
    }
    if (_password.trim().length == 0) {
      await showSimpleAlert(context, locales().login.passwordRequired);
      return;
    }

    final state = ScopedModel.of<AppState>(context);

    try {
      await state.tryEmailLogin(email: _email, password: _password);
      await state.registerDevice();
      Navigator.pushReplacementNamed(context, '/container');
    } catch (err) {
      if (err is ApiFailureError) {

        // case of inactivated email.
        if (err.code == 'INACTIVATED_MEMBER') {
          await Navigator.of(context).push(CupertinoPageRoute<bool>(
            builder: (BuildContext context) => 
              EmailUpgradeScene(memberToken: state.member.token)
          ));
          return;

        } else {
          await showSimpleAlert(context,
            locales().error.messageFromErrorCode(err.code));
        }

      } else {
        await showSimpleAlert(context,
          locales().error.messageFromErrorCode('UNKNOWN'));
      }
    }
  }

  void _onSimpleSignUp(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);

    var resp = await Navigator.of(context).push(CupertinoPageRoute<bool>(
      title: locales().login.withoutSignupButtonLabel,
      builder: (BuildContext context) => SimpleSignupScene()
    ));

    if (resp == true) {
      await model.registerDevice();
      Navigator.pushReplacementNamed(context, '/container');
    }
  }

  void _onEmailSignup(BuildContext context) async {
    await Navigator.of(context).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => SignupScene()
    ));
  }

  @override
  Widget build(BuildContext context) {
    locales().selectLanguage(context);
    final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().login.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(locales().login.loginIntroduce,
                    style: TextStyle(
                      fontSize: 17,
                      color: Styles.primaryFontColor
                    )
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: _buildLoginField(context, (String value) => _email = value)
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: _buildPasswordField(context, (String value) => _password = value)
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: CupertinoButton(
                    child: Text(locales().login.signInButton),
                    color: CupertinoColors.activeBlue,
                    onPressed: state.loading == true ? null :
                      () => _onLoginSubmit(context)
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: CupertinoButton(
                    child: Text(locales().login.simpleSignupButton),
                    color: CupertinoColors.activeGreen,
                    onPressed: state.loading == true ? null :
                      () => _onSimpleSignUp(context)
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: CupertinoButton(
                    child: Text(locales().login.signupButton),
                    onPressed: state.loading == true ? null :
                      () => _onEmailSignup(context)
                  )
                )
              ]
            ),
            Positioned(
              child: _buildProgress(context)
            )
          ]
        )
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
    CupertinoIcons.padlock_solid,
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

Widget _buildProgress(BuildContext context) {
  final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (state.loading == true) {
    return CupertinoActivityIndicator();
  }
  return Container();
}
import 'dart:async';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/components/gender_selector.dart';

class SignupScene extends StatefulWidget {
  @override
  State createState() => _SignupSceneState();
}

class _SignupSceneState extends State<SignupScene> {

  _SignupSceneState() {
    _loading = false;
  }

  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  String _gender;
  bool _loading;

  Future<void> _onSignUpClicked() async {
    if (_email.trim().length == 0) {
      await showSimpleAlert(context, locales().signupScene.emailRequired);
      return;
    }
    if (_password.trim().length == 0) {
      await showSimpleAlert(context, locales().signupScene.passwordRequired);
      return;
    }
    if (_passwordConfirm.trim().compareTo(_password.trim()) != 0) {
      await showSimpleAlert(context, locales().signupScene.passwordNotMatch);
      return;
    }
    if (_password.trim().length < 6) {
      await showSimpleAlert(context, locales().signupScene.passwordTooShort);
      return;
    }

    setState(() {
      _loading = true;
    });

    Locale locale = Localizations.localeOf(context);
    String region = locale.countryCode;
    String language = locale.languageCode;

    try {
      await authApi().requestEmailJoin(
        email: _email,
        password: _password,
        gender: parseGender(_gender),
        region: region,
        language: language
      );
      setState(() {
        _loading = false;
      });

      await showSimpleAlert(context, locales().signupScene.signupCompleted,
        title: locales().successTitle
      );
      Navigator.of(context).pop();

    } catch (err) {
      setState(() {
        _loading = false;
      });
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      }
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
        child: Stack(alignment: Alignment.center,
          children: [
            ListView(
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
                  margin: EdgeInsets.only(left: 10, right: 10, top: 2),
                  child: buildGenderSeletor(context,
                    gender: _gender,
                    genderSelectCallback: (String g) {
                      setState(() {
                        _gender = g;
                      });
                    }
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: CupertinoButton(
                    child: Text(locales().signupScene.joinButton),
                    color: CupertinoColors.activeBlue,
                    onPressed: _loading == true ? null : 
                      () => _onSignUpClicked()
                  )
                )
              ]
            ),
            Positioned(
              child: _buildProgress(context, loading: _loading)
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
      color: CupertinoColors.lightBackgroundGray),
    placeholder: locales().signupScene.emailPlaceHolder,
    onChanged: changedCallback,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 14.0),
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.lightBackgroundGray))
    )
  );


Widget _buildPasswordField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) =>
  CupertinoTextField(
    prefix: Icon(CupertinoIcons.padlock_solid,
      size: 28.0,
      color: CupertinoColors.lightBackgroundGray),
    placeholder: locales().signupScene.passwordPlaceHolder,
    onChanged: changedCallback,
    obscureText: true,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 14.0),
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.lightBackgroundGray))
    )
  );


Widget _buildPasswordConfirmField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) =>
  CupertinoTextField(
    prefix: Icon(CupertinoIcons.padlock_solid,
      size: 28.0,
      color: CupertinoColors.lightBackgroundGray),
    placeholder: locales().signupScene.passworConfirmPlaceHolder,
    onChanged: changedCallback,
    obscureText: true,
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 14.0),
    keyboardType: TextInputType.emailAddress,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.lightBackgroundGray))
    )
  );

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) {
  if (loading == true) {
    return CupertinoActivityIndicator();
  }
  return Container();
}
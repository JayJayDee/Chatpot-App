import 'dart:async';
import 'package:flutter/material.dart';
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
      Toast.show(locales().signupScene.emailRequired, context, duration: 2);
      return;
    }
    if (_password.trim().length == 0) {
      Toast.show(locales().signupScene.passwordRequired, context, duration: 2);
      return;
    }
    if (_passwordConfirm.trim().compareTo(_password.trim()) != 0) {
      Toast.show(locales().signupScene.passwordNotMatch, context, duration: 2);
      return;
    }
    if (_password.trim().length < 6) {
      Toast.show(locales().signupScene.passwordTooShort, context, duration: 2);
      return;
    }
    if (_gender == null) {
      Toast.show(locales().signupScene.genderRequired, context, duration: 2);
      return;
    }

    setState(() {
      _loading = true;
    });

    Locale locale = Localizations.localeOf(context);
    String region = locale.countryCode;
    String language = locale.languageCode;
    
    var resp = await authApi().requestEmailJoin(
      email: _email,
      password: _password,
      gender: _gender,
      region: region,
      language: language
    );
    // TODO: exception handling required.
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
                  child: _buildGenderSeletor(context,
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

typedef GenderSelectCallback (String gender);
Widget _buildGenderSeletor(BuildContext context, {
  @required String gender,
  @required GenderSelectCallback genderSelectCallback
}) =>
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(CupertinoIcons.person_solid,
        size: 28.0,
        color: CupertinoColors.lightBackgroundGray
      ),
      CupertinoButton(
        padding: EdgeInsets.only(left: 8, right: 0, top: 0, bottom: 0),
        child: Text(_currentGenderExpr(gender),
          style: TextStyle(
            color: CupertinoColors.lightBackgroundGray,
            fontWeight: FontWeight.w100,
            fontSize: 18
          )
        ),
        onPressed: () => {
          _showGenderPicker(context, 
            callback: genderSelectCallback,
            currentGender: gender
          )
        }
      )
    ]
  );

String _currentGenderExpr(String gender) {
  if (gender == null) return locales().signupScene.genderChooserLabel;
  else if (gender == 'M') return locales().signupScene.genderMale;
  else if (gender == 'F') return locales().signupScene.genderFemale;
  return null;
}

Future<String> _showGenderPicker(BuildContext context, {
  @required String currentGender,
  @required GenderSelectCallback callback
}) async {
  List<String> genderLabels = [
    locales().signupScene.genderFemale,
    locales().signupScene.genderMale
  ];
  List<String> genderValues = ['F', 'M'];

  int currentIdx = genderValues.indexOf(currentGender);
  if (currentIdx == -1) currentIdx = 0;

  final FixedExtentScrollController pickerScrollCtrl =
    FixedExtentScrollController(initialItem: currentIdx);

  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) =>
      _buildBottomPicker(
        CupertinoPicker(
          scrollController: pickerScrollCtrl,
          itemExtent: 32.0,
          diameterRatio: 32.0,
          backgroundColor: CupertinoColors.white,
          children: List<Widget>.generate(genderLabels.length,
            (int idx) => Center(child: Text(genderLabels[idx]))
          ),
          onSelectedItemChanged: (int idx) {
            callback(genderValues[idx]);
          }
        )
      )
  );
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: 180.0,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        onTap: () { },
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) {
  if (loading == true) {
    return CupertinoActivityIndicator();
  }
  return Container();
}
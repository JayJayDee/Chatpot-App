import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';

class SimpleSignupScene extends StatelessWidget {

  void _onSimpleSignUpClicked(BuildContext context) async {
    String gender = await _showGenderDialog(context);
    Locale locale = Localizations.localeOf(context);
    if (gender == null) return;

    final model = ScopedModel.of<AppState>(context);
    await model.simpleSignup(
      gender: gender,
      region: locale.countryCode,
      language: locale.languageCode
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('Start without sign-up'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text("Just start without complicated signing up."),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("But remember, signing up with mail account allows you to use the Chatpot on other devices."),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text('You can also register your mail account later.'),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _buildSignupButton(context, () => _onSimpleSignUpClicked(context)),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: _buildProgress(context)
                  )
                ]
              )
            )
          ],
        ),
      )
    );
  } 
}

Widget _buildSignupButton(BuildContext context, VoidCallback callback) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  VoidCallback buttonCallback;
  if (model.loading == false) buttonCallback = callback;
  return CupertinoButton(
    color: CupertinoColors.activeBlue,
    child: Text('Start without signup!'),
    onPressed: buttonCallback
  );
}

Widget _buildProgress(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (model.loading == true) {
    return Center(
      child: CupertinoActivityIndicator()
    );
  }
  return Center();
}

Future<dynamic> _showGenderDialog(BuildContext context) async =>
  showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Please select your gender'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Male'),
          onPressed: () => Navigator.pop(context, 'M')
        ),
        CupertinoDialogAction(
          child: Text('Female'),
          onPressed: () => Navigator.pop(context, 'M')
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context, null),
          isDestructiveAction: true
        )
      ],
    )
  );
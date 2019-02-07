import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/member-model.dart';

class SplashScene extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => SplashSceneState();
}

class SplashSceneState extends State<SplashScene> {

  bool _initCalled = false;
  Locale _locale;

  void _init(BuildContext context) async {
    if (_initCalled == true) return;
    _initCalled = true;

    Locale locale = Localizations.localeOf(context);
    _locale = locale;
    MemberModel.getInstance().tryAutoLogin(locale);
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    return ScopedModel<MemberModel>(
      model: MemberModel.getInstance(),
      child: ScopedModelDescendant<MemberModel>(
        builder: (context, child, model) {
          double progressOpacity = model.loading == true ? 1.0 : 0.0;
          double controlOpacity = model.loading == true ? 0.0 : 1.0;

          return Scaffold(
            body: Center(
              child: Stack(
                children: <Widget>[
                  Opacity(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('createAccount'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                        RaisedButton(
                          child: Text('go to main'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                        ),
                        RaisedButton(
                          child: Text('api request test'),
                          onPressed: () {
                            onApiTest();
                          },
                        ),
                      ],
                    ),
                    opacity: controlOpacity
                  ),
                  Opacity(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator()
                      ],
                    ),
                    opacity: progressOpacity
                  )
                ],
              )
            )
          );
        }
      )
    );
  }

  void onApiTest() async {

  }
}
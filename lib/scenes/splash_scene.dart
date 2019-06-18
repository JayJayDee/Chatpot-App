import 'dart:io';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

bool _init = false;

class SplashScene extends StatelessWidget {

  void onCreate(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    AppInitState state;

    try {
      state = await model.tryAutoLogin();
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        exit(0);
      }
    }

    // request grant access for push notification for iOS
    pushService().requestNotification(); // TODO: move another scene required..
    
    if (state == AppInitState.NEWCOMER) {
      var resp = await Navigator.pushReplacementNamed(context, '/login');
      if (resp == true) onCreate(context);

    } else if (state == AppInitState.LOGGED_IN) {
      await model.registerDevice();
      Navigator.pushReplacementNamed(context, '/container');
    }
  }

  @override
  Widget build(BuildContext context) {
    locales().selectLanguage(context);
    if (_init == false) {
      onCreate(context);
      _init = true;
    }
    return CupertinoPageScaffold(
      backgroundColor: Styles.splashBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/chatpot-icon.png'),
                    width: 200,
                    height: 200,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: _buildProgress(context),
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}

Widget _buildProgress(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (model.loading == true) {
    return CupertinoActivityIndicator();
  }
  return Opacity(
    child: CupertinoActivityIndicator(),
    opacity: 0.0
  );
}
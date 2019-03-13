import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

bool _init = false;

class SplashScene extends StatelessWidget {

  void onCreate(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    AppInitState state = await model.tryAutoLogin();

    // request grant access for push notification for iOS
    pushService().requestNotification();
    
    if (state == AppInitState.NEWCOMER) {
      var resp = await Navigator.pushNamed(context, '/login');
      if (resp == true) onCreate(context);

    } else if (state == AppInitState.LOGGED_IN) {
      await model.registerDevice();
      Navigator.pushReplacementNamed(context, '/container');
    }
  }

  @override
  Widget build(BuildContext context) {
    localeConverter().selectLanguage(context);
    if (_init == false) {
      onCreate(context);
      _init = true;
    }
    return CupertinoPageScaffold(
      backgroundColor: Styles.appBackground,
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
                    image: AssetImage('assets/chatpot_logo.png'),
                    width: 150,
                    height: 150,
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
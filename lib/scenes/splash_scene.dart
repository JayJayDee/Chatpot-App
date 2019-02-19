import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';

bool _init = false;

class SplashScene extends StatelessWidget {

  void sceneCreated(BuildContext context) {
    if (_init) return;
    _init = true;
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    model.tryAutoLogin().then((var res) {
      if (res == AppInitState.NEWCOMER) {
        print('newcomer action');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    sceneCreated(context);
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
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text('Chatpot', textScaleFactor: 1.5)
                  ),
                  Image(
                    image: AssetImage('assets/test_logo.png'),
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
}
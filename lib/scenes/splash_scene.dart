import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';

class SplashScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    image:AssetImage('assets/test_logo.png'),
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
                    child: CupertinoActivityIndicator(),
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
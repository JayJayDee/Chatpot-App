import 'package:flutter/cupertino.dart';

class SimpleSignupScene extends StatelessWidget {

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
                  Text("But remember, signing up with E-mail allows you to use the Chatpot on other devices."),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text('You can also register your mail account later.'),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: Text('Start without signup!'),
                    onPressed: () {

                    },
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
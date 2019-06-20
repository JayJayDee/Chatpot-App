import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class AboutScene extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().aboutScene.title)
      ),
      child: SafeArea(
        child: ListView(
          children: [

          ]
        )
      )
    );
  }
}
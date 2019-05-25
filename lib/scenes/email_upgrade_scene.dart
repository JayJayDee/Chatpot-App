import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class EmailUpgradeScene extends StatefulWidget {
  @override
  State createState() => _EmailUpgradeSceneState();
}

class _EmailUpgradeSceneState extends State<EmailUpgradeScene> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().emailUpgradeScene.title)
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
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class EmailUpgradeScene extends StatefulWidget {
  @override
  State createState() => _EmailUpgradeSceneState();
}

enum EmailUpgradeStatus {
  IDLE, SENT, CONFIRMED
}

class _EmailUpgradeSceneState extends State<EmailUpgradeScene> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Future.delayed(Duration.zero).then((data) {
      print(state);
    });
  }

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
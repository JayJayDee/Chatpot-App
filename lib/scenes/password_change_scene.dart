import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class PasswordChangeScene extends StatefulWidget {

  @override
  State createState() => _PasswordChangeSceneState();
}

class _PasswordChangeSceneState extends State<PasswordChangeScene> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().passwordChange.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: []
        )
      )
    );
  }
}
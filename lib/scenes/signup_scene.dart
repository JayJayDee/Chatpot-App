import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class SignupScene extends StatefulWidget {
  @override
  State createState() => _SignupSceneState();
}

class _SignupSceneState extends State<SignupScene> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().signupScene.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: ListView(
          children: []
        )
      )
    );
  }
}
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

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
          children: [
          ]
        )
      )
    );
  }
}

typedef TextChangedCallback (String text);

Widget _buildEmailField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) {
  return Center();  
}

Widget _buildPasswordField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) {
  return Center();
}

Widget _buildPasswordConfirmField(BuildContext context, {
  @required TextChangedCallback changedCallback
}) {
  return Center();
}
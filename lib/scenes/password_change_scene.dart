import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

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
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Text(locales().passwordChange.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Styles.primaryFontColor
                    )
                  )
                )
              ]
            ),
            _buildProgress(context)
          ]
        )
      )
    );
  }
}

Widget _buildOldPasswordField(BuildContext context) {
  return Container();
}

Widget _buildNewPasswordField(BuildContext context) {
  return Container();
}

Widget _buildNewPasswordConfirmField(BuildContext context) {
  return Container();
}

Widget _buildProgress(BuildContext context) {
  return Container();
}
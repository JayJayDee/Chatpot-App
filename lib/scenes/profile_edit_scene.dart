import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

class ProfileEditScene extends StatefulWidget {
  @override
  State createState() => _ProfileEditSceneState();
}

class _ProfileEditSceneState extends State<ProfileEditScene> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().mainBackground,
        previousPageTitle: locales().setting.title,
        actionsForegroundColor: styles().link,
        middle: Text(locales().settingThemeScene.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: []
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
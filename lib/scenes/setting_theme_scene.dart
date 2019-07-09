import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class SettingThemeScene extends StatefulWidget {
  @override
  State createState() => _SettingThemeSceneState();
}

class _SettingThemeSceneState extends State<SettingThemeScene> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().settingThemeScene.title),
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
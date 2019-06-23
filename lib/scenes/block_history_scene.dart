import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class BlockHistoryScene extends StatefulWidget {

  @override
  State createState() => _BlockHistorySceneState();
}

class _BlockHistorySceneState extends State<BlockHistoryScene> {
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().blockHistoryScene.title),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: []
            )
          ]
        )
      )
    );
  }
}
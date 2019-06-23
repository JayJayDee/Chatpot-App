import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class ReportHistoryScene extends StatefulWidget {

  @override
  State createState() => _ReportHistorySceneState();
}

class _ReportHistorySceneState extends State<ReportHistoryScene> {
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().reportHistoryScene.title),
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
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class NewRouletteScene extends StatefulWidget {
  @override
  State createState() => _NewRouletteSceneState();
}

class _NewRouletteSceneState extends State<NewRouletteScene> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().roulettechat.previous,
        actionsForegroundColor: styles().link,
        middle: Text(locales().roulettechat.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
        )
      )
    );
  }
}
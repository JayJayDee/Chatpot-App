import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class EulaScene extends StatefulWidget {
 
  @override
  State createState() => _EulaSceneState();
}

class _EulaSceneState extends State<EulaScene> {

  bool _loading;

  _EulaSceneState() {
    _loading = false;
  }

  void _onAgreeButtonClicked() async {
    Navigator.of(context).pop(true);
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().eulaScene.prevButtonLabel,
        middle: Text(locales().eulaScene.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container()
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: _buildAgreeButton(context,
                loading: _loading,
                callback: () => _onAgreeButtonClicked()
              )
            )
          ]
        )
      )
    );
  }
}

Widget _buildAgreeButton(BuildContext context, {
  @required bool loading,
  @required VoidCallback callback
}) {
  return CupertinoButton(
    child: Text(locales().eulaScene.agreeButtonLabel),
    color: CupertinoColors.activeBlue,
    onPressed: loading == true ? null : callback,
  );
}
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/styles.dart';

class EulaScene extends StatefulWidget {
 
  @override
  State createState() => _EulaSceneState();
}

class _EulaSceneState extends State<EulaScene> {

  bool _loading;

  _EulaSceneState() {
    _loading = false;
  }

  Future<void> _onAgreeButtonClicked() async {

  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Prev',
        middle: Text('End User License Agreement'),
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
    child: Text('Agree'),
    color: CupertinoColors.activeBlue,
    onPressed: loading == true ? null : callback,
  );
}
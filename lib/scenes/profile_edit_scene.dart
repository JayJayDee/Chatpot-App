import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

class ProfileEditScene extends StatefulWidget {
  @override
  State createState() => _ProfileEditSceneState();
}

class _ProfileEditSceneState extends State<ProfileEditScene> {

  bool _loading;

  _ProfileEditSceneState() {
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().setting.title,
        actionsForegroundColor: styles().link,
        middle: Text(locales().profileEditScene.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [

              ]
            ),
            Positioned(
              child: _buildProgress(context, loading: _loading)
            )
          ]
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();
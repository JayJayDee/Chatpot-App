import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/factory.dart';

class RoomDetailScene extends StatefulWidget {
  @override
  State createState() => _RoomDetailSceneState();
}

class _RoomDetailSceneState extends State<RoomDetailScene> {

  bool _loading;

  _RoomDetailSceneState() {
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    // TODO: fetch room detail info
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().roomDetailScene.title)
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
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() :
    Container();
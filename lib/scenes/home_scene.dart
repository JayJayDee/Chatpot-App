import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/components/room_row.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';

class HomeScene extends StatelessWidget implements EventReceivable {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home')
      ),
      child: SafeArea(
        child: ListView(children: <Widget>[
          Container(
          )
        ])
      )
    );
  }

  @override
  Future<void> onSelected() async {
    
  }
}

List<RoomRow> getPublicChatRows(BuildContext context, VoidCallback rowClickCallback) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  return [
    
  ];
}
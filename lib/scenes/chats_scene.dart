import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/models/app_state.dart';

class ChatsScene extends StatelessWidget implements EventReceivable {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Chats')
      ),
      child: Center()
    );
  }

  Future<void> onSelected(BuildContext context) async {
    print('CHATS_SCENE');
    final model = ScopedModel.of<AppState>(context);
    model.fetchMyRooms();
  }
}
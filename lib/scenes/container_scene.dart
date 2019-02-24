import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/scenes/home_scene.dart';
import 'package:chatpot_app/scenes/chats_scene.dart';
import 'package:chatpot_app/scenes/settings_scene.dart';

class ContainerScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var closer = _createCloser(context);

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.mail),
          title: Text('Chats'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          title: Text('Settings'),
        ),
      ]),
      tabBuilder: (context, index) {
        if (index == 0) {
          return HomeScene();
        } else if (index == 1) {
          return ChatsScene();
        } else if (index == 2) {
          return SettingsScene(closer);
        }
      },
    );
  }
}

_createCloser(BuildContext context) =>
  () {
    Navigator.pushNamed(context, '/splash');
  };
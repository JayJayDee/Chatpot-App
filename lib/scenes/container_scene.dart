import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/scenes/home_scene.dart';
import 'package:chatpot_app/scenes/chats_scene.dart';
import 'package:chatpot_app/scenes/settings_scene.dart';

class ContainerScene extends StatefulWidget {
  @override
  _ContainerSceneState createState() => _ContainerSceneState();
}

class _ContainerSceneState extends State<ContainerScene> {
  Map<String, Widget> _widgetMap;

  _ContainerSceneState() {
    _widgetMap = Map();
  }

  Widget _inflate(BuildContext context, int index) {
    String key = index.toString();
    Widget cached = _widgetMap[key];
    if (cached != null) return cached;
    
    if (key == '0') {
      cached = CupertinoTabView(
        builder: (BuildContext context) => HomeScene(),
        defaultTitle: 'Home',
      );

    } else if (key == '1') {
      cached = CupertinoTabView(
        builder: (BuildContext context) => ChatsScene(),
        defaultTitle: 'Chats',
      );
    }
    else if (key == '2') {
      cached = CupertinoTabView(
        builder: (BuildContext context) => SettingsScene(),
        defaultTitle: 'Settings',
      );
    }

    _widgetMap[key] = cached;
    return cached;
  }

  @override
  Widget build(BuildContext context) {
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
      tabBuilder: (context, index) => _inflate(context, index)
    );
  }
}
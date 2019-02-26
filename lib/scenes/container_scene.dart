import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/scenes/home_scene.dart';
import 'package:chatpot_app/scenes/chats_scene.dart';
import 'package:chatpot_app/scenes/settings_scene.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';

class ContainerScene extends StatefulWidget {
  @override
  _ContainerSceneState createState() => _ContainerSceneState();
}

class _WidgetWrapper {
  _WidgetWrapper({
    @required Widget widget,
    @required EventReceivable receivable
  }) {
    _widget = widget;
    _receivable = receivable;
  }
  Widget _widget;
  EventReceivable _receivable;

  Widget get widget => _widget;
  EventReceivable get receivable => _receivable;
}

class _ContainerSceneState extends State<ContainerScene> {
  Map<String, _WidgetWrapper> _widgetMap;

  _ContainerSceneState() {
    _widgetMap = Map();
  }

  _WidgetWrapper _inflate(BuildContext context, int index) {
    String key = index.toString();
    _WidgetWrapper cached = _widgetMap[key];
    if (cached != null) return cached;
      
    if (key == '0') {
      HomeScene scene = HomeScene();
      cached = _WidgetWrapper(
        widget: CupertinoTabView(
          builder: (BuildContext context) => scene,
          defaultTitle: 'Home',
        ),
        receivable: scene
      );
      

    } else if (key == '1') {
      ChatsScene scene = ChatsScene();
      cached = _WidgetWrapper(
        widget: CupertinoTabView(
          builder: (BuildContext context) => scene,
          defaultTitle: 'Chats',
        ),
        receivable: scene
      );
    }

    else if (key == '2') {
      SettingsScene scene = SettingsScene();
      cached = _WidgetWrapper(
        widget: CupertinoTabView(
          builder: (BuildContext context) => scene,
          defaultTitle: 'Settings',
        ),
        receivable: scene
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
      tabBuilder: (context, index) {
        _WidgetWrapper wrapper = _inflate(context, index);
        new Future.delayed(Duration(milliseconds: 100)).then((dynamic val) {
          wrapper.receivable.onSelected();
        });
        return wrapper.widget;
      }
    );
  }
}
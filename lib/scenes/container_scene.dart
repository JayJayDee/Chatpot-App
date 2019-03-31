import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/scenes/home_scene.dart';
import 'package:chatpot_app/scenes/chats_scene.dart';
import 'package:chatpot_app/scenes/settings_scene.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';

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

class _ContainerSceneState extends State<ContainerScene> with WidgetsBindingObserver {
  Map<String, _WidgetWrapper> _widgetMap;
  Map<String, bool> _initMap;
  AppState _model;

  _ContainerSceneState() {
    _widgetMap = Map();
    _initMap = Map();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var func = () async {
      if (state == AppLifecycleState.resumed) {
        await _model.fetchMyRooms();
      }
    };
    func();
  }

  void _initFcm(BuildContext context) {
    final model = ScopedModel.of<AppState>(context);
    pushService().attach(state: model);
  }

  _WidgetWrapper _inflate(BuildContext context, int index) {
    String key = index.toString();
    _WidgetWrapper cached = _widgetMap[key];
    if (cached != null) return cached;
      
    if (key == '0') {
      HomeScene scene = HomeScene(parentContext: context);
      cached = _WidgetWrapper(
        widget: scene,
        receivable: scene
      );
    } 
    
    else if (key == '1') {
      ChatsScene scene = ChatsScene(parentContext: context);
      cached = _WidgetWrapper(
        widget:  scene,
        receivable: scene
      );
    }

    else if (key == '2') {
      SettingsScene scene = SettingsScene(parentContext: context);
      cached = _WidgetWrapper(
        widget: scene,
        receivable: scene
      );
    }

    _widgetMap[key] = cached;
    return cached;
  }

  @override
  Widget build(BuildContext context) {
    _initFcm(context);
    final model = ScopedModel.of<AppState>(context);
    _model = model;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.tea),
            title: Text(locales().home.title)
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.chatProcessing),
            title: Text(locales().chats.title)
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.settings),
            title: Text(locales().setting.title)
          )
        ],
        onTap: (int index) {
          var wrapper = _inflate(context, index);
          wrapper.receivable.onSelected(context);
        }
      ),
      tabBuilder: (context, index) {
        _WidgetWrapper wrapper = _inflate(context, index);
        var inited = _initMap[index.toString()];
        if (inited == null && index == 0) {
          _initMap[index.toString()] = true;
          Future.delayed(Duration(milliseconds: 200)).then((dynamic val) {
            var delayedWrapper = _widgetMap[index.toString()];
            if (delayedWrapper != null) delayedWrapper.receivable.onSelected(context);
          });
        }

        return CupertinoTabView(
          builder: (BuildContext context) => 
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                wrapper.widget,
                Positioned(
                  child: _buildProgressBar(context)
                )
              ],
            )
        );
      }
    );
  }
}

Widget _buildProgressBar(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (model.loading == true) return CupertinoActivityIndicator();
  return Center();
}
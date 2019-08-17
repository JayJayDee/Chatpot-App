import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/scenes/home_scene.dart';
import 'package:chatpot_app/scenes/chats_scene.dart';
import 'package:chatpot_app/scenes/settings_scene.dart';
import 'package:chatpot_app/scenes/tabbed_scene_interface.dart';
import 'package:chatpot_app/scenes/message_scene.dart';
import 'package:chatpot_app/scenes/new_roulette_scene.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/custom_tab_scaffold.dart';
import 'package:chatpot_app/components/welcome_oobe_dialog.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/entities/push.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/entities/notification.dart';

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

final listenerName = 'CONTAINER_SCENE';
final tag = 'PUSH_LOG ';

class _ContainerSceneState extends State<ContainerScene> with WidgetsBindingObserver, TabActor {
  Map<String, _WidgetWrapper> _widgetMap;
  Map<String, bool> _initMap;
  CustomTabScaffold _container;
  int _currentIndex;

  _ContainerSceneState() {
    _widgetMap = Map();
    _initMap = Map();
    _currentIndex = 0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    print("$tag initstate");

    pushService().setPushListener(listenerName, _onPushArrival);
    pushService().attach();

    Future.delayed(Duration(seconds: 1)).then((v) {
      showWelcomeOobeDialog(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    print("$tag dispose");

    pushService().unsetPushListener(listenerName);
    super.dispose();
  }

  @override
  Future<void> changeTab(int tabIdx) async {
    setState(() {
      _currentIndex = tabIdx;
    });
    var wrapper = _inflate(context, tabIdx);
    wrapper.receivable.onSelected(context);
    _currentIndex = tabIdx;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final model = ScopedModel.of<AppState>(context);

    var func = () async {
      if (state == AppLifecycleState.resumed) {
        print('RESUMED!');
        pushService().setPushListener(listenerName, _onPushArrival);

        await model.fetchMyRooms();
        await model.translateMyRooms();

        pushService().requestCallbackPushes();

      } else if (state == AppLifecycleState.paused) {
        // pushService().unsetPushListener(listenerName);
      }
    };
    func();
  }

  void _onPushArrival(Push push) async {
    final state = ScopedModel.of<AppState>(context);

    // FOREGROUND / BACKGROUND COMMON 
    if (push.pushType == PushType.MESSAGE) {
      if (state.myRooms.length == 0) {
        print('MY ROOM EMPTY!');
        await state.fetchMyRooms();
        await state.translateMyRooms();
      }
      Message msg = push.getContent();
      state.addSingleMessageFromPush(msg: msg);
    }

  
    if (push.pushOrigin == PushOrigin.FOREGROUND) {
      if (push.pushType == PushType.NOTIFICATION) {
        PushNotification noti = push.getContent();

        if (noti.notificationType == PushNotificationType.CHAT_ROULLETE_MATCHED) {
          showToast(locales().roulettechat.matchedToastMessage,
            duration: Duration(milliseconds: 1000),
            position: ToastPosition(align: Alignment.bottomCenter)
          );
          await state.fetchMyRooms(refreshAll: true);
          await state.translateMyRooms();
        }

        if (noti.notificationType == PushNotificationType.CHAT_ROULETTE_DESTROYED) {
          showToast(locales().roulettechat.destroyedToastMessage,
            duration: Duration(milliseconds: 1000),
            position: ToastPosition(align: Alignment.bottomCenter)
          );
          await state.fetchMyRooms(refreshAll: true);
          await state.translateMyRooms();
        }
      }
    }


    // BACKGROUND ONLY
    if (push.pushOrigin == PushOrigin.BACKGROUND) {
      if (push.pushType == PushType.MESSAGE) {
        Message msg = push.getContent(); 
        var rooms = state.myRooms.where((r) =>
        r.roomToken == msg.to.token).toList();

        if (rooms.length > 0) {
          if (rooms[0].shown == false) {
            await Navigator.of(context).push(CupertinoPageRoute<bool>(
              builder: (BuildContext context) => MessageScene(
                room: rooms[0]
              )
            ));
          }
        }
      }

      if (push.pushType == PushType.NOTIFICATION) {
        PushNotification noti = push.getContent();
        if (noti.notificationType == PushNotificationType.CHAT_ROULLETE_MATCHED) {
          await Navigator.of(context).push(CupertinoPageRoute<bool>(
            builder: (BuildContext context) => NewRouletteScene()
          ));

        } else if (noti.notificationType == PushNotificationType.CHAT_ROULETTE_DESTROYED) {
          await state.fetchMyRooms(refreshAll: true);
          await state.translateMyRooms();
        }
      }
    }
  }


  _WidgetWrapper _inflate(BuildContext context, int index) {
    String key = index.toString();
    _WidgetWrapper cached = _widgetMap[key];
    if (cached != null) return cached;
      
    if (key == '0') {
      HomeScene scene = HomeScene(
        parentContext: context,
        actor: this
      );
      cached = _WidgetWrapper(
        widget: scene,
        receivable: scene
      );
    } 
    
    else if (key == '1') {
      ChatsScene scene = ChatsScene(
        parentContext: context,
        actor: this
      );
      cached = _WidgetWrapper(
        widget: scene,
        receivable: scene
      );
    }

    else if (key == '2') {
      SettingsScene scene = SettingsScene(
        parentContext: context,
        actor: this
      );
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
    _container = CustomTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: styles().tabBarBackground,
        activeColor: styles().tabBarActive,
        inactiveColor: styles().tabBarInactive,
        currentIndex: _currentIndex,
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
          _currentIndex = index;
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
    return _container;
  }
}

Widget _buildProgressBar(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (model.loading == true) return CupertinoActivityIndicator();
  return Center();
}
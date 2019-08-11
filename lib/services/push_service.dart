import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:io' show Platform;
import 'package:chatpot_app/models/model_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatpot_app/entities/push.dart';

typedef BackgroundActionCallback (BackgroundAction action);
typedef PushListener (Push push);

final tag = 'PUSH_LOG_SERVICE ';

enum PushType {
  MESSAGE, NOTIFICATION
}

enum NotificationType {
  RouletteMatched
}

class PushService {
  FirebaseMessaging _messaging;

  Queue<Push> _backgroundPushQueue;
  Map<String, PushListener> _pushListeners;

  PushService({
    @required FirebaseMessaging msg
  }) {
    _messaging = msg;
    _backgroundPushQueue = Queue();
    _pushListeners = Map();
  }

  void setPushListener(String key, PushListener listener) {
    _pushListeners[key] = listener;
    print("$tag REGISTERED_LISTENER");
  }

  void unsetPushListener(String key) {
    _pushListeners.remove(key);
    print("$tag UNREGISTERED_LISTENER, LENGTH = ${_pushListeners.length}");
  }

  void attach() {
    print("$tag ATTACH");
    _messaging.configure(
      onMessage: _onMessage,
      onResume: _onResume,
      onLaunch: _onLaunch
    );
    print("$tag ATTACH_CONFIGURE");
    _firePushCallbacks();
  }

  void requestCallbackPushes() {
    _firePushCallbacks();
  }

  void requestNotification() {
    _messaging.requestNotificationPermissions(
      IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true
      )
    );
  }

  Future<String> accquireDeviceToken() async {
    return await _messaging.getToken();
  }

  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    Push push = _parsePush(message, PushOrigin.FOREGROUND);

    _backgroundPushQueue.addFirst(push);
    print("$tag ADDED_ONE_MESSAGE_FOREGROUND");

    _firePushCallbacks();
  }

  Future<dynamic> _onResume(Map<String, dynamic> message) async {
    print('ON_RESUME FIRED');
    Push push = _parsePush(message, PushOrigin.BACKGROUND);

    _backgroundPushQueue.addFirst(push);
    print("$tag ADDED_ONE_MESSAGE_BACKGROUND");
    _firePushCallbacks();
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    print('ON_LAUNCH FIRED');
    Push push = _parsePush(message, PushOrigin.BACKGROUND);

    _backgroundPushQueue.addFirst(push);
    print("$tag ADDED_ONE_MESSAGE_BACKGROUND");
    _firePushCallbacks();
  }

  void _firePushCallbacks() {
    print("$tag FIRE_PUSH_CALLBACKS");
    if (_backgroundPushQueue.isEmpty == true) {
      print("$tag FIRE_PUSH_CALLBACKS EMPTY");
      return;
    }

    Push push = _backgroundPushQueue.removeLast();
    print("$tag FIRE_PUSH_CALLBACKS POP_ONE");

    _pushListeners.keys.forEach((k) {
      var listener = _pushListeners[k];
      Future.delayed(Duration.zero).then((v) => listener(push));
    });
    print("$tag FIRE_PUSH_CALLBACKS CALLS_BACK ${_pushListeners.length}");
  }

  Push _parsePush(Map<String, dynamic> message, PushOrigin origin) {
    if (message.isEmpty) return null;

    Map<String, dynamic> source;
    if (Platform.isIOS) {
      source = message;
    } else if (Platform.isAndroid) {
      source = message['data'].cast<String, dynamic>();
    }

    if (source == null) return null;

    String payload = source['payload'];
    Map<String, dynamic> payloadMap = jsonDecode(payload);

    Push push = Push.fromJson(payloadMap, origin);
    return push;
  } 
}
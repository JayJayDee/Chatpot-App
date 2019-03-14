import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:meta/meta.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/message.dart';

class PushService {
  FirebaseMessaging _messaging;
  AppState _state;

  PushService({
    @required FirebaseMessaging msg
  }) {
    _messaging = msg;
  }

  void attach({
    @required AppState state
  }) {
    _state = state;
    _messaging.configure(
      onMessage: _onMessage,
      onResume: _onResume,
      onLaunch: _onLaunch
    );
  }

  void requestNotification() {
    _messaging.requestNotificationPermissions();
  }

  Future<String> accquireDeviceToken() async {
    return await _messaging.getToken();
  }

  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    print('ON_MESSAGE FIRED');
    Message msg = _parseMessage(message);
    print(msg);
    _state.addSingleMessage(msg: msg);
  }

  Future<dynamic> _onResume(Map<String, dynamic> message) async {
    print('ON_RESUME FIRED');
    Message msg = _parseMessage(message);
    print(msg);
    _state.addSingleMessage(msg: msg);
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    print('ON_LAUNCH FIRED');
    print(message);
  }

  Message _parseMessage(Map<String, dynamic> message) {
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
    Message msg = Message.fromJson(payloadMap);
    return msg;
  } 
}
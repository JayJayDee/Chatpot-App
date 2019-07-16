import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/model_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/message.dart';

class PushService {
  FirebaseMessaging _messaging;
  AppState _state;
  BuildContext _context;

  PushService({
    @required FirebaseMessaging msg
  }) {
    _messaging = msg;
  }

  void attach({
    @required AppState state,
    @required BuildContext context
  }) {
    _state = state;
    _context = context;
    _messaging.configure(
      onMessage: _onMessage,
      onResume: _onResume,
      onLaunch: _onLaunch
    );
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
    Message msg = _parseMessage(message);
    _state.addSingleMessageFromPush(msg: msg);
  }

  Future<dynamic> _onResume(Map<String, dynamic> message) async {
    print('ON_RESUME FIRED');
    print(message);
    Message msg = _parseMessage(message);
    _state.addSingleMessageFromPush(msg: msg);
    _onBackgroundMessage(msg);
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    print('ON_LAUNCH FIRED');
    print(message);

    Message msg = _parseMessage(message);
    _onBackgroundMessage(msg);
  }
  
  void _onBackgroundMessage(Message message) async {
    final state = ScopedModel.of<AppState>(_context);

    if (message.to.type == MessageTarget.ROOM) {
      String roomToken = message.to.token;
      var action = BackgroundAction(payload: roomToken, type: BackgroundActionType.ROOM);
      state.setBackgroundAction(action);
    }
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
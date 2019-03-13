import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatpot_app/storage/auth_accessor.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/storage/pref_auth_accessor.dart';
import 'package:chatpot_app/apis/default_requester.dart';
import 'package:chatpot_app/apis/auth_api.dart';
import 'package:chatpot_app/apis/member_api.dart';
import 'package:chatpot_app/apis/room_api.dart';
import 'package:chatpot_app/apis/message_api.dart';
import 'package:chatpot_app/utils/auth_crypter.dart';
import 'package:chatpot_app/utils/default_auth_crypter.dart';
import 'package:chatpot_app/utils/locale_converter.dart';
import 'package:chatpot_app/services/push_service.dart';

Map<String, dynamic> _instances;

void initFactory() {
  _instances = new Map<String, dynamic>();
  _instances['FirebaseMessaging'] = FirebaseMessaging();
  _instances['AuthAccessor'] = PrefAuthAccessor();
  _instances['AuthCrypter'] = DefaultAuthCrypter();
  _instances['LocaleConverter'] = LocaleConverter();

  _instances['MemberRequester'] = _initMemberRequester();
  _instances['RoomRequester'] = _initRoomRequseter();
  _instances['MessageRequester'] = _initMessageRequester();
  _instances['AuthApi'] = AuthApi(requester: _memberRequester());
  _instances['MemberApi'] = MemberApi(requester: _memberRequester());
  _instances['RoomApi'] = RoomApi(requester: _roomRequester());
  _instances['MessageApi'] = MessageApi(requester: _messageRequester());
  _instances['PushService'] = PushService(msg: _firebaseMessaging());
}

Requester _initMemberRequester() => DefaultRequester(
  crypter: authCrypter(),
  accessor: authAccessor(),
  baseUrl: 'http://dev-auth.chatpot.chat'
);

Requester _initRoomRequseter() => DefaultRequester(
  crypter: authCrypter(),
  accessor: authAccessor(),
  baseUrl: 'http://dev-room.chatpot.chat'
);

Requester _initMessageRequester() => DefaultRequester(
  crypter: authCrypter(),
  accessor: authAccessor(),
  baseUrl: 'http://dev-message.chatpot.chat'
);

// internal factory uses.
Requester _memberRequester() => _instances['MemberRequester'];
Requester _roomRequester() => _instances['RoomRequester'];
Requester _messageRequester() => _instances['MessageRequester'];
FirebaseMessaging _firebaseMessaging() => _instances['FirebaseMessaging'];

// exports.
AuthAccessor authAccessor() => _instances['AuthAccessor'];
AuthApi authApi() => _instances['AuthApi'];
MemberApi memberApi() => _instances['MemberApi'];
RoomApi roomApi() => _instances['RoomApi'];
MessageApi messageApi() => _instances['MessageApi'];
AuthCrypter authCrypter() => _instances['AuthCrypter'];
LocaleConverter localeConverter() => _instances['LocaleConverter'];
FirebaseMessaging firebaseMessaging() => _instances['FirebaseMessaging'];
PushService pushService() => _instances['PushService'];
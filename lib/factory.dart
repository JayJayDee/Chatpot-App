import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chatpot_app/storage/auth_accessor.dart';
import 'package:chatpot_app/storage/pref_auth_accessor.dart';
import 'package:chatpot_app/storage/messages_accessor.dart';
import 'package:chatpot_app/storage/sqlite_messages_accessor.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/default_requester.dart';
import 'package:chatpot_app/apis/auth_api.dart';
import 'package:chatpot_app/apis/member_api.dart';
import 'package:chatpot_app/apis/room_api.dart';
import 'package:chatpot_app/apis/message_api.dart';
import 'package:chatpot_app/apis/activation_api.dart';
import 'package:chatpot_app/apis/asset_api.dart';
import 'package:chatpot_app/apis/translate_api.dart';
import 'package:chatpot_app/utils/auth_crypter.dart';
import 'package:chatpot_app/utils/default_auth_crypter.dart';
import 'package:chatpot_app/locales/root_locale_converter.dart';
import 'package:chatpot_app/services/push_service.dart';
import 'package:chatpot_app/storage/translation_cache_accessor.dart';
import 'package:chatpot_app/storage/sqlite_translation_cache_accessor.dart';

Map<String, dynamic> _instances;

void initFactory() {
  _instances = new Map<String, dynamic>();
  _instances['FirebaseMessaging'] = FirebaseMessaging();
  _instances['AuthAccessor'] = PrefAuthAccessor();
  _instances['AuthCrypter'] = DefaultAuthCrypter();
  _instances['LocaleConverter'] = RootLocaleConverter();
  _instances['MessagesAccessor'] = SqliteMessagesAccessor(dbName: 'messages.db');
  _instances['TranslationCacheAccessor'] = SqliteTranslationCacheAccessor(dbName: 'translation.db');

  _instances['MemberRequester'] = _initMemberRequester();
  _instances['RoomRequester'] = _initRoomRequseter();
  _instances['MessageRequester'] = _initMessageRequester();
  _instances['AuthApi'] = AuthApi(requester: _memberRequester());
  _instances['MemberApi'] = MemberApi(requester: _memberRequester());
  _instances['RoomApi'] = RoomApi(requester: _roomRequester());
  _instances['MessageApi'] = MessageApi(requester: _messageRequester());
  _instances['AssetApi'] = AssetApi(requester: _initAssetRequester());
  _instances['TranslateApi'] = TranslateApi(requester: _initTranslateRequester());
  _instances['PushService'] = PushService(msg: _firebaseMessaging());
  _instances['ActivationApi'] = ActivationApi(requester: _memberRequester());
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

Requester _initAssetRequester() => DefaultRequester(
  crypter: authCrypter(),
  accessor: authAccessor(),
  baseUrl: 'http://dev-asset.chatpot.chat'
);

Requester _initTranslateRequester() => DefaultRequester(
  crypter: authCrypter(),
  accessor: authAccessor(),
  baseUrl: 'http://dev-translate.chatpot.chat'
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
AssetApi assetApi() => _instances['AssetApi'];
TranslateApi translateApi() => _instances['TranslateApi'];
ActivationApi activationApi() => _instances['ActivationApi'];
AuthCrypter authCrypter() => _instances['AuthCrypter'];
RootLocaleConverter locales() => _instances['LocaleConverter'];
FirebaseMessaging firebaseMessaging() => _instances['FirebaseMessaging'];
PushService pushService() => _instances['PushService'];
MessagesAccessor messagesAccessor() => _instances['MessagesAccessor'];
TranslationCacheAccessor translationCacheAccessor() => _instances['TranslationCacheAccessor'];
import 'package:chatpot_app/storage/auth_accessor.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/storage/pref_auth_accessor.dart';
import 'package:chatpot_app/apis/default_requester.dart';
import 'package:chatpot_app/apis/auth_api.dart';
import 'package:chatpot_app/apis/member_api.dart';
import 'package:chatpot_app/utils/auth_crypter.dart';
import 'package:chatpot_app/utils/default_auth_crypter.dart';

Map<String, dynamic> _instances;

void initFactory() {
  _instances = new Map<String, dynamic>();
  _instances['AuthAccessor'] = PrefAuthAccessor();
  _instances['AuthCrypter'] = DefaultAuthCrypter();

  _instances['MemberRequester'] = _initMemberRequester();
  _instances['RoomRequester'] = _initRoomRequseter();
  _instances['AuthApi'] = AuthApi(requester: _memberRequester());
  _instances['MemberApi'] = MemberApi(requester:_memberRequester());
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

// internal factory uses.
Requester _memberRequester() => _instances['MemberRequester'];
Requester _roomRequester() => _instances['RoomRequester'];

// exports.
AuthAccessor authAccessor() => _instances['AuthAccessor'];
AuthApi authApi() => _instances['AuthApi'];
MemberApi memberApi() => _instances['MemberApi'];
AuthCrypter authCrypter() => _instances['AuthCrypter'];
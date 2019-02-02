import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/request.dart';

Function req = request('http://dev-auth.chatpot.chat');

class ResAuth {
  final String sessionKey;
  ResAuth({
    this.sessionKey
  });
}

Future<ResAuth> auth({ String loginId, String password }) async {
  const url = '/';
  var resp = await req(url, RequestMethod.Post, body: {
    "login_id": loginId,
    "password": password
  });
  return ResAuth(sessionKey: resp['session_key']);
}

Future<ResAuth> reauth(Auth auth) async {
  String refreshKey = _buildRefreshKey(auth);
  var resp = await req('/reauth', RequestMethod.Post, body: {
    'token': auth.authToken
  }, query: {
    'session_key': auth.sessionKey,
    'refresh_key': refreshKey
  });
  return ResAuth(sessionKey: resp['session_key']);
}

String _buildRefreshKey(Auth auth) {
  String rawKey = "$auth.token$auth.sessionKey$auth.secret";
  var bytes = utf8.encode(rawKey);
  var hashed = sha256.convert(bytes);
  return "$hashed";
}
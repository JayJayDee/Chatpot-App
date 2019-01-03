import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatpot_app/entities/member.dart';

class ResCreateMember {
  final Nick nick;
  final String token;
  final String passphrase;
  ResCreateMember({ this.nick, this.token, this.passphrase });
}

class ResGetMember {
  
}

class ResMemberLogin {
  final String sessionId;
  ResMemberLogin({ this.sessionId });
}

const base = 'http://dev-api.chatpot.chat';

Future<ResCreateMember> memberCreate({ String region, String language, String gender }) async {
  const url = "$base/member";
  var resp = await http.post(url, body: {
    "region": region,
    "language": language,
    "gender": gender
  });
  Map<String, dynamic> decoded = jsonDecode(resp.body);
  
  ResCreateMember res = ResCreateMember(
    nick: Nick.fromJson(decoded['nick']),
    token: decoded['token'],
    passphrase: decoded['passphrase']);
  return res;
}

Future<ResMemberLogin> memberLogin({ String loginId, String password }) async {
  const url = "$base/auth";
  var resp = await http.post(url, body: {
    "login_id": loginId,
    "password": password
  });
  Map<String, dynamic> decoded = jsonDecode(resp.body);
  ResMemberLogin res = ResMemberLogin(
    sessionId: decoded['session_id']
  );
  return res;
}
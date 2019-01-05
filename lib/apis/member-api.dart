import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/request.dart';

class ResCreateMember {
  final Nick nick;
  final String token;
  final String passphrase;
  ResCreateMember({ this.nick, this.token, this.passphrase });
}

class ResGetMember {
  final Nick nick;
  final String region;
  final String language;
  final String gender;
  final String token;
  ResGetMember({ 
    this.nick, 
    this.region,
    this.language,
    this.gender,
    this.token});
}

class ResMemberLogin {
  final String sessionId;
  ResMemberLogin({ this.sessionId });
}

Future<ResCreateMember> memberCreate({ String region, String language, String gender }) async {
  const url = '/member';
  var resp = await request(url, RequestMethod.Post, body: {
    "region": region,
    "language": language,
    "gender": gender
  });
  ResCreateMember res = ResCreateMember(
    nick: Nick.fromJson(resp['nick']),
    token: resp['token'],
    passphrase: resp['passphrase']);
  return res;
}

Future<ResMemberLogin> memberLogin({ String loginId, String password }) async {
  const url = "$base/auth";
  var resp = await request(url, RequestMethod.Post, body: {
    "login_id": loginId,
    "password": password
  });
  ResMemberLogin res = ResMemberLogin(
    sessionId: resp['session_id']
  );
  return res;
}

Future<ResGetMember> memberGet({ String token, String sessionKey }) async {
  String url = "$base/member/$token";
  var resp = await request(url, RequestMethod.Get, query: {
    'session_key': sessionKey
  });
  ResGetMember res = ResGetMember(
    nick: Nick.fromJson(resp['nick']),
    region: resp['region'],
    language: resp['language'],
    gender: resp['gender'],
    token: resp['token']);
  return res;
}
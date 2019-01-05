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

Future<ResGetMember> memberGet(Auth auth, { String token }) async {
  String url = "/member/$token";
  var resp = await requestWithAuth(auth, url, RequestMethod.Get);
  ResGetMember res = ResGetMember(
    nick: Nick.fromJson(resp['nick']),
    region: resp['region'],
    language: resp['language'],
    gender: resp['gender'],
    token: resp['token']);
  return res;
}
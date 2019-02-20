import 'package:chatpot_app/entities/member.dart';

class SimpleJoinApiResp {
  Nick nick;
  String token;
  String passphrase;

  SimpleJoinApiResp();

  factory SimpleJoinApiResp.fromJson(Map<String, dynamic> map) {
    var res = SimpleJoinApiResp();
    res.nick = Nick.fromJson(map['nick']);
    res.token = map['token'];
    res.passphrase = map['passphrase'];
    return res;
  }

  @override
  toString() => "SIMPLEJOIN_API_RESP: $nick, $token";
}

class AuthApiResp {
  String sessionKey;

  AuthApiResp();

  factory AuthApiResp.fromJson(Map<String, dynamic> map) {
    var res = AuthApiResp();
    res.sessionKey = map['session_key'];
    return res;
  }

  @override
  toString() => "AUTH_API_RESP: $sessionKey";
}
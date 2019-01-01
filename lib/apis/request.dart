import 'dart:async';
import 'package:chatpot_app/entities/member.dart';
import 'package:http/http.dart' as http;

class ResCreateMember {
  final Nick nick;
  final String token;
  final String passphrase;
  ResCreateMember({ this.nick, this.token, this.passphrase });
}

class ReqCreateMember {
  String region;
  String language;
  String gender;
  ReqCreateMember({ this.region, this.language, this.gender });
}

const base = 'http://dev-api.chatpot.chat';

Future<ResCreateMember> memberCreate({ String region, String language, String gender }) async {
  const url = "$base/member";
  var resp = await http.post(url, body: {
    "region": region,
    "language": language,
    "gender": gender
  });
  print(resp.body);
  return null;
}
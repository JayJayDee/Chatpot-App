import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/errors.dart';

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

const base = 'http://dev-api.chatpot.chat';

Future<ResCreateMember> memberCreate({ String region, String language, String gender }) async {
  const url = "$base/member";
  var resp = await _request(url, _RequestMethod.Post, body: {
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
  var resp = await _request(url, _RequestMethod.Post, body: {
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
  var resp = await _request(url, _RequestMethod.Get, query: {
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

enum _RequestMethod {
  Get, Post
}
Future<Map<String, dynamic>> _request(String url, _RequestMethod method, {Map<String, dynamic> query, Map<String, dynamic> body }) async {
  http.Response resp;
  if (method == _RequestMethod.Get) {
    resp = await http.get(_buildUrlWithQuery(url, query));
  } else if (method == _RequestMethod.Post) {
    resp = await http.post(_buildUrlWithQuery(url, query), body: body);
  }

  Map<String, dynamic> responseMap;
  try {
    responseMap = jsonDecode(resp.body);
  } catch (err) {
    throw new HttpRequestError('UNEXPECTED_REQUEST_ERROR', 500);
  }

  if (resp.statusCode == 200) {
    return responseMap;
  } else if (resp.statusCode == 401 && responseMap['code'] == 'SESSION_EXPIRED') {
    // TODO: additional request for accquire session key 
  }
  throw new HttpRequestError(responseMap['code'], resp.statusCode);
}

String _buildUrlWithQuery(String url, Map<String, dynamic> query) {
  if (query == null || query.keys.toList().length > 0) {
    return url;
  }
  URLQueryParams qs = URLQueryParams();
  query.keys.toList().map((String key) {
    qs.append(key, query[key]);
  });
  String qsExpr = qs.toString();
  return "$query&$qsExpr";
}
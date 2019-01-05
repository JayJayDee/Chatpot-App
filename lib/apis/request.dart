import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/errors.dart';

const _base = 'http://dev-api.chatpot.chat';
String _sessionKey;

Future<Map<String, dynamic>> requestWithAuth(Auth auth, String uri, RequestMethod method, {Map<String, dynamic> query, Map<String, dynamic> body }) async  {
  Map<String, dynamic> resp = new Map();
  if (_sessionKey == null) {
    _sessionKey = await _accquireSessionKey(auth);
  }

  try {
    if (query == null) query = new Map<String, dynamic>();
    query['session_key'] = _sessionKey;
    resp = await request(uri, method, query: query, body: body);
  } catch (err) {
    if (err is HttpRequestError && 
        err.getMessage() == 'SESSION_EXPIRED' && 
        err.getStatus() == 401) {
      _sessionKey = await _accquireSessionKey(auth);
      query['session_key'] = _sessionKey;
      resp = await request(uri, method, query: query, body: body);
    }
  }
  return resp;
}

enum RequestMethod {
  Get, Post
}
Future<Map<String, dynamic>> request(String url, RequestMethod method, {Map<String, dynamic> query, Map<String, dynamic> body }) async {
  String convertedUrl = _buildUrlWithQuery(url, query);
  http.Response resp;
  if (method == RequestMethod.Get) {
    resp = await http.get(convertedUrl);
  } else if (method == RequestMethod.Post) {
    resp = await http.post(convertedUrl, body: body);
  }

  Map<String, dynamic> responseMap;
  try {
    responseMap = jsonDecode(resp.body);
  } catch (err) {
    throw new HttpRequestError('UNEXPECTED_REQUEST_ERROR', 500);
  }

  if (resp.statusCode == 200) {
    return responseMap;
  }
  throw new HttpRequestError(responseMap['code'], resp.statusCode);
}

String _buildUrlWithQuery(String url, Map<String, dynamic> query) {
  if (query == null) return "$_base$url";  
  List<String> keys = query.keys.toList();
  if (keys.length == 0) return "$_base$url";

  URLQueryParams qs = URLQueryParams();
  for (var i = 0; i < keys.length; i++) {
    String key = keys[i];
    qs.append(key, query[key]);
  }
  String qsExpr = qs.toString();
  return "$_base$url?$qsExpr";
}

Future<String> _accquireSessionKey(Auth auth) async {
  Map<String, dynamic> authResp = await request('/auth', RequestMethod.Post, body: {
    'login_id': auth.authToken,
    'password': auth.secret
  });
  String sessKey = authResp['session_key'];
  return sessKey;
}
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

import 'package:chatpot_app/apis/errors.dart';

const base = 'http://dev-api.chatpot.chat';

enum RequestMethod {
  Get, Post
}
Future<Map<String, dynamic>> request(String url, RequestMethod method, {Map<String, dynamic> query, Map<String, dynamic> body }) async {
  http.Response resp;
  if (method == RequestMethod.Get) {
    resp = await http.get(_buildUrlWithQuery(url, query));
  } else if (method == RequestMethod.Post) {
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
  }
  throw new HttpRequestError(responseMap['code'], resp.statusCode);
}

String _buildUrlWithQuery(String url, Map<String, dynamic> query) {
  if (query == null || query.keys.toList().length > 0) {
    return "$base$url";
  }
  URLQueryParams qs = URLQueryParams();
  query.keys.toList().map((String key) {
    qs.append(key, query[key]);
  });
  String qsExpr = qs.toString();
  return "$base$url&$qsExpr";
}
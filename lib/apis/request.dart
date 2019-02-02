import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';
import 'package:chatpot_app/apis/errors.dart';

const _base = 'http://dev-auth.chatpot.chat';

enum RequestMethod {
  Get, Post
}

Function request(String baseUrl) =>
  (String url, RequestMethod method,
    { Map<String, dynamic> query, Map<String, dynamic> body}) async {
      String convertedUrl = _buildUrlWithQuery(baseUrl, url, query);
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
    };

String _buildUrlWithQuery(String base, String url, Map<String, dynamic> query) {
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
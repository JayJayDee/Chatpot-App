import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:chatpot_app/storage/auth_accessor.dart';
import 'package:chatpot_app/utils/auth_crypter.dart';

class DefaultRequester implements Requester {
  String _baseUrl;
  AuthAccessor _authAccessor;
  AuthCrypter _authCrypter;

  DefaultRequester({
    @required String baseUrl,
    @required AuthAccessor accessor,
    @required AuthCrypter crypter
  }) {
    _baseUrl = baseUrl;
    _authAccessor = accessor;
    _authCrypter = crypter;
  }

  Future<Map<String, dynamic>> request({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    String wholeUrl = _buildWholeUrl(url, qs: qs);
    var resp;
    try {
      if (method == HttpMethod.GET) resp = await http.get(wholeUrl);
      else if (method == HttpMethod.POST) resp = await http.post(wholeUrl, body: body);
      Map<String, dynamic> respMap = jsonDecode(resp.body);
      if (resp.statusCode != 200) {
        if (resp.statusCode == 401 && respMap['code'] == 'SESSION_EXPIRED') {
          throw new ApiSessionExpiredError();
        }
        throw new ApiFailureError('API request failure',
          resp.statusCode, code: respMap['code']);
      }
      return respMap;
    } catch (err) {
      throw new ApiFailureError('failed to decode response: ${resp.body}', 500);
    }
  }

  Future<Map<String, dynamic>> requestWithAuth({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    try {
      return await this.request(url: url, 
        method: method, qs: qs, body: body);
    } catch (err) {
      if (err is ApiSessionExpiredError) {
        url = 'http://dev-auth.chatpot.chat/auth/reauth';

        // TODO: add crypter.
        var resp = http.post(url,
          body: {
            'token': _authAccessor.getToken()
          }
        );
      }
      throw err;
    }
  }

  String _buildWholeUrl(String url, { Map<String, dynamic> qs }) {
    String qsExpr = '';
    if (qs != null) {
      URLQueryParams builder = URLQueryParams();
      qs.forEach((String k, dynamic v) {
        builder.append(k, v);
      });
      qsExpr = '?${qs.toString()}';
    }
    return "$_baseUrl$url$qsExpr";
  }
}
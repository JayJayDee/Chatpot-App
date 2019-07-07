import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
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

  void _preValidateParams({
    @required Map<String, dynamic> qs,
    @required Map<String, dynamic> body
  }) {
    if (qs != null) {
      qs.keys.toList().forEach((String key) {
        if (qs[key] == null) qs.remove(key);
      });
    }

    if (body != null) {
      body.keys.toList().forEach((String key) {
        if (body[key] == null) body.remove(key);
      });
    }
  }

  Future<dynamic> request({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    _preValidateParams(qs: qs, body: body);

    String wholeUrl = _buildWholeUrl("$_baseUrl$url", qs: qs);
    print("REQUEST WHOLE URL = $wholeUrl");

    var resp;
    Map<String, dynamic> respMap;
    List<dynamic> respList;

    try {
      if (method == HttpMethod.GET) resp = await http.get(wholeUrl);
      else if (method == HttpMethod.POST) resp = await http.post(wholeUrl, body: body);
      else if (method == HttpMethod.PUT) resp = await http.put(wholeUrl, body: body);
    } catch (err) {
      if (err is SocketException) {
        throw new ApiFailureError(err.message, 500, code: 'NETWORK_ERROR');
      }
      throw err;
    }

    try {
      respMap = jsonDecode(resp.body);
    } catch (err) {
      try {
        respList = jsonDecode(resp.body);
      } catch (err) {
        throw new ApiFailureError('failed to decode response: ${resp.body}', 500);
      }
    }

    if (resp.statusCode != 200) {
      if (resp.statusCode == 401 && respMap['code'] == 'SESSION_EXPIRED') {
        throw new ApiSessionExpiredError();
      }
      throw new ApiFailureError(respMap['message'],
        resp.statusCode, code: respMap['code']);
    }

    var ret;
    if (respMap != null) {
      print('RESPONSE WAS MAP');
      ret = respMap;
    }
    if (respList != null) {
      print('RESPONSE WAS LIST');
      ret = respList;
    } 
    return ret;
  }

  Future<dynamic> upload({
    @required String url,
    @required HttpMethod method,
    @required File file,
    Map<String, dynamic> body,
    Map<String, dynamic> qs,
    UploadProgressCallback progress
  }) async {
    var dio = Dio();
    String wholeUrl = _buildWholeUrl("$_baseUrl$url", qs: qs);
    try {
      // TODO: refactor required.
      FormData formData = FormData.from({
        "image": UploadFileInfo(file, basename(file.path))
      });

      if (body != null && body.keys.length > 0) {
        body.keys.forEach((String k) {
          formData.add(k, body[k]);
        });
      }

      var resp = await dio.post(wholeUrl,
        data: formData,
        onSendProgress: (received, total) {
          int percent = (received / total * 100).round();
          if (progress != null) progress(percent);
        }
      );
      Map<String, dynamic> respMap = jsonDecode(resp.toString());
      return respMap;
    } catch (err) {
      if (err is SocketException) {
        throw new ApiFailureError(err.message, 500, code: 'NETWORK_ERROR');
      }
      throw err;
    }
  }

  Future<dynamic> uploadWithAuth({
    @required String url,
    @required HttpMethod method,
    @required File file,
    Map<String, dynamic> qs,
    UploadProgressCallback progress
  }) async {
    // TODO: to be implemented.
  }

  Future<dynamic> requestWithAuth({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    _preValidateParams(qs: qs, body: body);

    String sessKey;
    try {
      sessKey = await _authAccessor.getSessionKey();
      if (qs == null) qs = new Map();  
      qs['session_key'] = sessKey;

      print("TRYING CALL API WITH SESSKEY: $sessKey");

      return await this.request(url: url, 
        method: method, qs: qs, body: body);
    } catch (err) {
      if (err is ApiSessionExpiredError) {
        String token = await _authAccessor.getToken();
        String password = await _authAccessor.getPassword();
        String oldSessionKey = await _authAccessor.getSessionKey();

        String refreshKey = _authCrypter.createRefreshToken(
          token: token,
          oldSessionKey: oldSessionKey,
          password: password
        );

        String reauthUrl = 'http://dev-auth.chatpot.chat/auth/reauth';
        String wholeUrl = _buildWholeUrl(reauthUrl, qs: {
          'session_key': oldSessionKey,
          'refresh_key': refreshKey
        });

        print("REAUTH_URL = $wholeUrl");

        var reauthResp = await http.post(wholeUrl, body: { 'token': token });
        Map<String, dynamic> reauthRespMap;
        try {
          reauthRespMap = jsonDecode(reauthResp.body);
        } catch (err) {
          throw new ApiFailureError('fail to decode response', 500);
        }

        if (reauthResp.statusCode != 200) {
          throw new ApiFailureError(reauthRespMap['message'], reauthResp.statusCode, code: reauthRespMap['code']);
        }

        String newSessionKey = reauthRespMap['session_key'];
        _authAccessor.setSessionKey(newSessionKey);

        return await requestWithAuth(
          url: url,
          method: method,
          qs: qs,
          body: body
        );
      }

      if (err is SocketException) {
        throw new ApiFailureError(err.message, 500, code: 'NETWORK_ERROR');
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
      qsExpr = '?${builder.toString()}';
    }
    return "$url$qsExpr";
  }
}
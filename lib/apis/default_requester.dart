import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
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

  Future<dynamic> request({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    String wholeUrl = _buildWholeUrl("$_baseUrl$url", qs: qs);
    print("REQUEST WHOLE URL = $wholeUrl");
    var resp;
    Map<String, dynamic> respMap;
    List<dynamic> respList;

    if (method == HttpMethod.GET) resp = await http.get(wholeUrl);
    else if (method == HttpMethod.POST) resp = await http.post(wholeUrl, body: body);

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
    Map<String, dynamic> qs,
    UploadProgressCallback progress
  }) async {
    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    int length = await stream.length;
    String wholeUrl = _buildWholeUrl("$_baseUrl$url", qs: qs);
    print("UPLOAD_URL = $wholeUrl");
    try {
      var uri = Uri.parse(wholeUrl);
      print('uri made');
      var request = new http.MultipartRequest('POST', uri);
      request.files.add(new http.MultipartFile('image', stream, length,
        filename: basename(file.path)
      ));
      print('req made');
      var resp = await request.send();
      print('req completed');
      print(resp.statusCode);
      resp.stream.transform(utf8.decoder).listen((value) => print(value));
    } catch (err) {
      print('UPLOAD_ERROR OCCURED!!');
      print(err);
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
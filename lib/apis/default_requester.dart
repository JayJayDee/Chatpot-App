import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/storage/auth_accessor.dart';

class DefaultRequester implements Requester {
  String _baseUrl;
  AuthAccessor _authAccessor;

  DefaultRequester({
    @required String baseUrl,
    @required AuthAccessor accessor
  }) {
    _baseUrl = baseUrl;
    _authAccessor = accessor;
  }

  Future<Map<String, dynamic>> request({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    return null;
  }

  Future<Map<String, dynamic>> requestWithAuth({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  }) async {
    Map<String, dynamic> resp;
    try {
      resp = await this.request(url: url, 
        method: method, qs: qs, body: body);
    } catch (err) {
      
    }
    return null;
  }
}
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';
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
    String wholeUrl = _buildWholeUrl(url, qs: qs);
    print(wholeUrl);
    // TODO: request with url & params.
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
      // TODO: to be implemented
    }
    return null;
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
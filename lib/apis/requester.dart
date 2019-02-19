import 'package:meta/meta.dart';

enum HttpMethod {
  GET, POST
}

abstract class Requester {
  Future<Map<String, dynamic>> request({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  });

  Future<Map<String, dynamic>> requestWithAuth({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  });
}
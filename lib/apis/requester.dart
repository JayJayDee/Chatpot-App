import 'dart:async';
import 'package:meta/meta.dart';

enum HttpMethod {
  GET, POST
}

abstract class Requester {
  Future<dynamic> request({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  });

  Future<dynamic> requestWithAuth({
    @required String url,
    @required HttpMethod method,
    Map<String, dynamic> qs,
    Map<String, dynamic> body
  });
}
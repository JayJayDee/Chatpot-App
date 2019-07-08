import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';

enum HttpMethod {
  GET, POST, PUT, DELETE
}

typedef UploadProgressCallback (int);

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

  Future<dynamic> upload({
    @required String url,
    @required HttpMethod method,
    @required File file,
    Map<String, dynamic> body,
    Map<String, dynamic> qs,
    UploadProgressCallback progress
  });

  Future<dynamic> uploadWithAuth({
    @required String url,
    @required HttpMethod method,
    @required File file,
    Map<String, dynamic> qs,
    UploadProgressCallback progress
  });
}
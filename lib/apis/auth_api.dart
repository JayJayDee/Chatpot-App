import 'dart:async';
import 'package:chatpot_app/entities/member.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class AuthApi {
  Requester _requester;

  AuthApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<SimpleJoinApiResp> requestSimpleJoin({
    @required String region,
    @required String language,
    @required String gender
  }) async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/member',
      method: HttpMethod.POST,
      body: {
        'region': region,
        'language': language,
        'gender': gender
      }
    );
    return SimpleJoinApiResp.fromJson(resp);
  }

  Future<EmailJoinApiResp> requestEmailJoin({
    @required String email,
    @required String password,
    @required String region,
    @required String language,
    @required String gender
  }) async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/member/email',
      method: HttpMethod.POST,
      body: {
        'email': email,
        'password': password,
        'region': region,
        'language': language,
        'gender': gender
      }
    );
    return EmailJoinApiResp.fromJson(resp);
  }

  Future<AuthApiResp> requestAuth({
    @required String loginId,
    @required String password
  }) async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/auth',
      method: HttpMethod.POST,
      body: {
        'login_id': loginId,
        'password': password
      }
    );
    return AuthApiResp.fromJson(resp);
  }

  Future<EmailAuthApiResp> requestEmailAuth({
    @required String email,
    @required String password
  }) async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/auth/email',
      method: HttpMethod.POST,
      body: {
        'login_id': email,
        'password': password
      }
    );
    return EmailAuthApiResp.fromJson(resp);
  }
}
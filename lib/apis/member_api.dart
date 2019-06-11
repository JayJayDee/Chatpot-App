import 'dart:async';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/entities/member.dart';

class MemberApi {
  Requester _requester;

  MemberApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<Member> fetchMy(String token) async {
    var resp = await _requester.requestWithAuth(
      url: "/member/$token",
      method: HttpMethod.GET
    );
    return Member.fromJson(resp);
  }

  Future<PasswordChangeResp> changePassword({
    @required String memberToken,
    @required String currentPassword,
    @required String newPassword
  }) async {
    Map<String, dynamic> resp = await _requester.requestWithAuth(
      url: "/member/$memberToken/password",
      method: HttpMethod.PUT,
      body: {
        'member_token': memberToken,
        'current_password': currentPassword,
        'new_password': newPassword
      }
    );
    return PasswordChangeResp.fromJson(resp);
  }
}
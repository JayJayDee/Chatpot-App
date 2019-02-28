import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';
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
}
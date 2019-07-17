import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class GachaApi {
  Requester _requester;

  GachaApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<Gacha> requestGachaStatus({
    @required String memberToken
  }) async {
    Map<String, dynamic> resp = await _requester.requestWithAuth(
      url: "/gacha/$memberToken/status",
      method: HttpMethod.GET
    );
    return Gacha.fromJson(resp);
  }

  Future<NickGachaResp> requestNickGacha({
    @required String memberToken,
  }) async {
    Map<String, dynamic> resp = await _requester.requestWithAuth(
      url: "/gacha/$memberToken/nick",
      method: HttpMethod.POST
    );
    return NickGachaResp.fromJson(resp);
  }

  Future<AvatarGachaResp> requestAvatarGacha({
    @required String memberToken,
  }) async {
    Map<String, dynamic> resp = await _requester.requestWithAuth(
      url: "/gacha/$memberToken/avatar",
      method: HttpMethod.POST
    );
    return AvatarGachaResp.fromJson(resp);
  }
}
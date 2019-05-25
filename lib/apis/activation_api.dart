import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class ActivationApi {
  Requester _requester;

  ActivationApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<ActivationStatusResp> requestAcitvationStatus({
    @required String memberToken
  }) async {
    Map<String, dynamic> resp = await _requester.requestWithAuth(
      url: '/activate/app/status',
      method: HttpMethod.GET,
      qs: {
        'member_token': memberToken
      }
    );
    return ActivationStatusResp.fromJson(resp);
  }
}
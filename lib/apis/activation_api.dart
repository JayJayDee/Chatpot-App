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
    return null;
  }
}
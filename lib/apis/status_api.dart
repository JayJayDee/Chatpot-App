import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class StatusApi {
  Requester _requester;

  StatusApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<ServiceStatus> requestServiceStatus() async {
    Map<String, dynamic> resp = await _requester.requestWithAuth(
      url: '/status.json',
      method: HttpMethod.GET
    );
    return ServiceStatus.fromJson(resp);
  }
}
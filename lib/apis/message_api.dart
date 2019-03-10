import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class MessageApi {
  Requester _requester;

  MessageApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<MessagesApiResp> requestMessages({
    @required String roomToken
  }) async {
    // TODO: to be implemented.
    return null;
  }

  Future<void> requestRegister({
    @required String memberToken,
    @required String deviceToken
  }) async {
    await _requester.requestWithAuth(
      url: '/device/register',
      method: HttpMethod.POST,
      body: {
        'member_token': memberToken,
        'device_token': deviceToken
      }
    );
  }

  Future<void> requestUnregister({
    @required String memberToken,
    @required String deviceToken
  }) async {
    await _requester.requestWithAuth(
      url: '/device/unregister',
      method: HttpMethod.POST,
      body: {
        'member_token': memberToken,
        'device_token': deviceToken
      }
    );   
  }
}
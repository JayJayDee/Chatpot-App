import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class TranslateApi {
  Requester _requester;

  TranslateApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<List<TranslateResp>> requestTranslateRooms({
    @required List<TranslateParam> params,
    @required String fromLocale,
    @required String toLocale
  }) async {
    List<TranslateResp> response = List();
    // TODO: api request & parse required
    return response;
  }
}
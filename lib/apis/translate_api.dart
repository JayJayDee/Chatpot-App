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
    @required List<TranslateParam> queries,
    @required String toLocale
  }) async {
    String query = jsonEncode(queries.map((p) => p.toMap()).toList());

    var resp = await _requester.requestWithAuth(
      url: "/translate/room",
      method: HttpMethod.GET,
      qs: {
        'to': toLocale,
        'query': query
      }
    );
    List<dynamic> list = resp;
    List<TranslateResp> retList = list.map((map) => TranslateResp.fromJson(map)).toList();
    return retList;
  }

  Future<List<TranslateResp>> requestTranslateMessages({
    @required List<TranslateParam> queries,
    @required String toLocale
  }) async {
    String query = jsonEncode(queries.map((p) => p.toMap()).toList());

    var resp = await _requester.requestWithAuth(
      url: "/translate/message",
      method: HttpMethod.GET,
      qs: {
        'to': toLocale,
        'query': query
      }
    );
    List<dynamic> list = resp;
    List<TranslateResp> retList = list.map((map) => TranslateResp.fromJson(map)).toList();
    return retList;
  }
}
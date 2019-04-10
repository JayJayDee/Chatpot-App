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
    @required String toLocale
  }) async {
    List<TranslateResp> response = List();
    String query = jsonEncode(params.map((p) => p.toMap()).toList());
    print("TRANSLATE_QUERY_EXPR = $query");

    var resp = await _requester.requestWithAuth(
      url: "/translate/room",
      method: HttpMethod.GET,
      qs: {
        'to': toLocale,
        'query': query
      }
    );
    print(resp);
    return response;
  }
}
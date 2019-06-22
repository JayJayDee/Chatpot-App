import 'package:meta/meta.dart';
import 'dart:async';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class ReportApi {
  Requester _requester;

  ReportApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<void> requestReport({
    @required String memberToken,
    @required String targetToken,
    @required String roomToken,
    @required ReportType reportType,
    String comment
  }) async {
    // TODO: to be implement
  }

  Future<List<ReportStatus>> requestMyReports({
    @required String memberToken
  }) async {
    List<ReportStatus> list = List();
    // TODO: to be implement
    return list;
  }
}
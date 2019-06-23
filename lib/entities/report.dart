enum ReportType {
  HATE, SEXUAL, ETC
}

enum ReportState {
  REPORTED, IN_PROGRESS, DONE
}

class ReportStatus {
  ReportType reportType;
  ReportState status;
  String comment;
  String result;
  String regDate;

  ReportStatus();

  factory ReportStatus.fromJson(Map<String, dynamic> map) {
    var resp = ReportStatus();
    resp.reportType = ReportStatus._parseReportType(map['report_type']);
    resp.status = ReportStatus._parseReportState(map['status']);
    resp.comment = map['comment'];
    resp.result = map['result'];
    resp.regDate = map['reg_date'];
    return resp;
  }

  static ReportType _parseReportType(String reportTypeExpr) {
    if (reportTypeExpr == 'HATE') return ReportType.HATE;
    else if (reportTypeExpr == 'SEXUAL') return ReportType.SEXUAL;
    return ReportType.ETC;
  }

  static ReportState _parseReportState(String reportStateExpr) {
    if (reportStateExpr == 'REPORTED') return ReportState.REPORTED;
    else if (reportStateExpr == 'IN_PROGRES') return ReportState.IN_PROGRESS;
    else if (reportStateExpr == 'DONE') return ReportState.DONE;
    return null;
  }

  @override
  String toString() => "$reportType $status";
}
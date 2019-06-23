import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/locales/root_locale_converter.dart';

class ReportHistorySceneLocales {
  String language;
  RootLocaleConverter root;

  ReportHistorySceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '내 신고 내역';
    else if (language == 'ja') return '私の報告履歴';
    return 'My reporting history';
  }

  String reportExpr(ReportState state) {
    if (state == ReportState.REPORTED) {
      if (language == 'ko') return '신고완료';
      else if (language == 'ja') return '申告完了';
      return 'Reported';
    } else if (state == ReportState.IN_PROGRESS) {
      if (language == 'ko') return '진행중';
      else if (language == 'ja') return '進行中';
      return 'Progress';
    } else if (state == ReportState.DONE) {
      if (language == 'ko') return '처리완료';
      else if (language == 'ja') return '申告完了';
      return 'Done';
    }
    return '';
  }

  String reportDescription(ReportState state) {
    if (state == ReportState.REPORTED) {
      if (language == 'ko') {
        return '''신고가 완료되었으며, Chatpot 관리자의 조회를 대기하고 있습니다. 최대 24시간 내에 조회 및 조치 결과를 알려드립니다.''';
      } else if (language == 'ja') {
        return 'あなたのレポートは完成し、Chatpot管理者がそれを見るのを待っています。 お問い合わせやアクションの結果は24時間以内にお知らせします。';
      }
      return '''Your report has been completed and waiting for Chatpot administrator to view it. We will notify you of inquiries and action results within 24 hours.''';
    }

    else if (state == ReportState.IN_PROGRESS) {
      if (language == 'ko') {
        return '''Chatpot 관리자가 신고를 접수하였으며, 신고를 검토 중입니다. 24시간 내에 조치하고 결과를 알려드립니다.''';
      } else if (language == 'ja') {
        return 'Chatpot管理者があなたの苦情を受け取り、あなたの苦情を見直しています。 24時間以内に回答し、結果をお知らせします。';
      }
      return '''The Chatpot administrator has received your complaint and is reviewing your complaint. We will respond within 24 hours and inform you of the result.''';
    }

    else if (state == ReportState.DONE) {
      if (language == 'ko') {
        return '''신고에 대한 처리가 완료되었습니다. 앞으로도 적극적인 신고를 부탁드립니다.''';
      } else if (language == 'ja') {
        return 'あなたの報告は処理されました。 活発な報告をありがとう。';
      }
      return '''Your report has been processed. Thank you for your active reporting.''';
    }
    return '';
  }

  String reportTimeUtc(String time) {
    if (language == 'ko') return """신고시간 (UTC):
$time""";
    else if (language == 'ja') return """申告時刻（UTC）：
$time""";
    return """Report time (UTC):
$time""";
  }

  String reportTitle(ReportStatus report) {
    String reportType = '';
    if (report.reportType == ReportType.HATE) reportType = root.reportScene.hateLabel;
    else if (report.reportType == ReportType.SEXUAL) reportType = root.reportScene.sexualLabel;
    else reportType = root.reportScene.etcLabel;

    if (language == 'ko') return "$reportType에 대한 신고";
    else if (language == 'ja') return "$reportTypeに対する申告";
    return "Report about $reportType";
  }

  String get emptyReports {
    if (language == 'ko') return '신고내역이 없습니다.';
    else if (language == 'ja') return '利用可能な報告はありません';
    return 'No reportings available';
  }
}
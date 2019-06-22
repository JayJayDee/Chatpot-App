import 'package:chatpot_app/locales/root_locale_converter.dart';

class ReportSceneLocales {
  String language;
  RootLocaleConverter root;

  ReportSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '다른 사용자 신고';
    else if (language == 'ja') return 'ユーザーを報告';
    return 'Report an user';
  }

  String get prevButtonLabel {
    if (language == 'ko') return '이전';
    else if (language == 'ja') return '前';
    return 'Prev';
  }

  String get description1 {
    if (language == 'ko') return '선택한 사용자가 신고 대상이 맞는지 확인해주세요.';
    else if (language == 'ja') return '選択したユーザーがレポートの対象かどうかを確認してください。';
    return 'Please check if the selected user is the target of the report.';
  }

  String get reportButtonLabel {
    if (language == 'ko') return '신고';
    else if (language == 'ja') return '提出';
    return 'Report';
  }
}
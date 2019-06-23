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
}
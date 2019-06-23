import 'package:chatpot_app/locales/root_locale_converter.dart';

class BlockHistorySceneLocales {
  String language;
  RootLocaleConverter root;

  BlockHistorySceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '내 차단 내역';
    else if (language == 'ja') return 'ブロッキング履歴';
    return 'My blocking history';
  }
}
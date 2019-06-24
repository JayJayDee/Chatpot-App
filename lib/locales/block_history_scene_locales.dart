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

  String get emptyBlocks {
    if (language == 'ko') return '차단 내역이 없습니다.';
    else if (language == 'ja') return 'ブロック履歴はありません。';
    return 'No blocking history.';
  }

  String blockDate(DateTime dt) {
    if (language == 'ko') return "차단일시: ${dt.year}/${dt.month}/${dt.day} ${dt.hour}:${dt.minute}:${dt.second}";
    else if (language == 'ja') return 'ブロック履歴はありません。';
    return "Blocked at ${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute}:${dt.second}";
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class NewRouletteSceneLocales {
  String language;
  RootLocaleConverter root;

  NewRouletteSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '새 랜덤 채팅';
    else if (language == 'ja') return '新しいランダムチャット';
    return 'New chat roulette';
  }

  String get previous {
    if (language == 'ko') return '이전';
    else if (language == 'ja') return '前';
    return 'Prev';
  }
}
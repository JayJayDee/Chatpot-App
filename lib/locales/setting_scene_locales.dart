import 'package:chatpot_app/locales/root_locale_converter.dart';

class SettingSceneLocales {
  String language;
  RootLocaleConverter root;

  SettingSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '설정';
    else if (language == 'ja') return '設定';
    return 'Settings';
  }
}
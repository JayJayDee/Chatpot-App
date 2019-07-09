import 'package:chatpot_app/locales/root_locale_converter.dart';

class SettingThemeSceneLocales {
  String language;
  RootLocaleConverter root;

  SettingThemeSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '테마';
    else if (language == 'ja') return 'テーマ';
    return 'Theme';
  }
}
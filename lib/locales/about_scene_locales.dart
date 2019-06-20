import 'package:chatpot_app/locales/root_locale_converter.dart';

class AboutSceneLocales {
  String language;
  RootLocaleConverter root;

  AboutSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return 'Chatpot에 대하여';
    else if (language == 'ja') return 'Chatpotについて';
    return 'About Chatpot';
  }
}
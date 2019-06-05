import 'package:chatpot_app/locales/root_locale_converter.dart';

class SimpleSignupSceneLocales {
  String language;
  RootLocaleConverter root;

  SimpleSignupSceneLocales ({
      this.language,
      this.root
  });

  String get title {
    if (this.language == 'ko') return '회원가입 없이 바로 시작하기';
    else if (this.language == 'ja') return '登録せずに開始';
    return 'Start without signing up';
  }
}
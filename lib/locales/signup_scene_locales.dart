import 'package:chatpot_app/locales/root_locale_converter.dart';

class SignupSceneLocales {
  String language;
  RootLocaleConverter root;

  SignupSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '이메일로 회원가입';
    else if (language == 'ja') return 'メールで登録';
    return 'Sign up with email';
  }
}
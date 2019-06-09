import 'package:chatpot_app/locales/root_locale_converter.dart';

class PasswordChangeSceneLocales {
  String language;
  RootLocaleConverter root;

  PasswordChangeSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '비밀번호 변경';
    else if (language == 'ja') return 'パスワードを変更する';
    return 'Change password';
  }
}
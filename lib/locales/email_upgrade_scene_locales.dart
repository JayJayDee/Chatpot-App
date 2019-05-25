import 'package:chatpot_app/locales/root_locale_converter.dart';

class EmailUpgradeSceneLocales {
  String language;
  RootLocaleConverter root;

  EmailUpgradeSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '이메일 계정 연결';
    else if (language == 'ja') return 'メールアカウントを登録';
    return 'Connect an email account';
  }
}
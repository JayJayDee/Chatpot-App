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

  String get signout {
    if (language == 'ko') return '로그아웃';
    else if (language == 'ja') return 'ログアウト';
    return 'Sign out';
  }

  String get signin {
    if (language == 'ko') return '로그인';
    else if (language == 'ja') return 'ログイン';
    return 'Sign in';
  }

  String get about {
    if (language == 'ko') return 'Chatpot에 대하여..';
    else if (language == 'ja') return 'Chatpotについて..';
    return 'about Chatpot..';
  }

  String get donation {
    if (language == 'ko') return '개발자에게 커피한잔 쏘기';
    else if (language == 'ja') return '開発者をコーヒーに捧げる';
    return 'Treat a developer to a cup of coffee';
  }
}
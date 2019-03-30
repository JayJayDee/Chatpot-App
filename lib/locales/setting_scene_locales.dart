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

  String get linkMail {
    if (language == 'ko') return '메일 계정 연결';
    else if (language == 'ja') return 'メールアカウントを追加する';
    return 'Add an Email account';
  }

  String get simpleSignoutWarning {
    if (language == 'ko') return "간편 로그인으로 접속하고 있습니다.\n이 방법으로 로그인한 사용자가 로그아웃 하면, 모든 계정 및 채팅 정보가 사라지며 복구가 불가능합니다.\n이를 방지하기 위해서 설정 메뉴에서 메일 주소를 연결할 수 있습니다.\n\n정말로 로그아웃을 진행하시겠습니까?";
    else if (language == 'ja') return '開発者をコーヒーに捧げる'; // TODO: translate
    return 'Treat a developer to a cup of coffee'; // TODO: translate
  }

  String get signoutDialogTitle {
    if (language == 'ko') return "로그아웃을 진행하시겠습니까?";
    else if (language == 'ja') return '開発者をコーヒーに捧げる'; // TODO: translate
    return 'Treat a developer to a cup of coffee'; // TODO: translate
  }

  String get cancel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return '取消';
    return 'Cancel';
  }
}
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
    return 'About Chatpot..';
  }

  String get donation {
    if (language == 'ko') return '개발자에게 커피한잔 쏘기';
    else if (language == 'ja') return '開発者をコーヒーに捧げる';
    return 'Treat a developer to a cup of coffee';
  }

  String get theme {
    if (language == 'ko') return '테마 설정';
    else if (language == 'ja') return 'テーマ設定';
    return 'Theme setting';
  }

  String get myReports {
    if (language == 'ko') return '내 신고 내역 보기';
    else if (language == 'ja') return '私申告内訳照会';
    return 'My reporting history';
  }

  String get myBlocks {
    if (language == 'ko') return '내 차단 내역 보기';
    else if (language == 'ja') return '私遮断した履歴照会';
    return 'My blocking history';
  }

  String get changePassword {
    if (language == 'ko') return '비밀번호 변경';
    else if (language == 'ja') return '開発者をコーヒーに捧げる';
    return 'Change password';
  }

  String get linkMail {
    if (language == 'ko') return '메일 계정 연결';
    else if (language == 'ja') return 'メールアカウントを追加する';
    return 'Add an Email account';
  }

  String get simpleSignoutWarning {
    if (language == 'ko') return "간편 로그인으로 접속하고 있습니다.\n이 방법으로 로그인한 사용자가 로그아웃 하면, 모든 계정 및 채팅 정보가 사라지며 복구가 불가능합니다.\n이를 방지하기 위해서 설정 메뉴에서 메일 주소를 연결할 수 있습니다.\n\n정말로 로그아웃을 진행하시겠습니까?";
    else if (language == 'ja') return '''あなたは簡易ログインとしてログインしています。
Simple Loginでサインインすると、サインアウトするとアカウントとチャットの情報がすべて消えてしまい、元に戻せなくなります。
これを防ぐために、あなたはあなたのEメールをこのアカウントにリンクすることができます。

ログアウトしてよろしいですか？''';
    return '''You are logged in as Simple Login.
If you sign in with Simple Login, all your account and chat information will disappear when you sign out, and you will not be able to recover it.
To prevent this, you can link your email to this account.

Are you sure you want to log out?''';
  }

  String get signoutWarning {
    if (language == 'ko') return '로그아웃 하시겠습니까?';
    else if (language == 'ja') return 'ログアウトしてよろしいですか？';
    return 'Are you sure you want to log out?';
  }

  String get cancel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return '取消';
    return 'Cancel';
  }

  String loggedIn(String email) {
    if (language == 'ko') return "$email 으로 로그인됨";
    else if (language == 'ja') return "$emailとしてログインしました";
    return "Signed in as $email";
  }

  String currentVersion(String version) {
    if (language == 'ko') return "Chatpot version dev-$version";
    else if (language == 'ja') return "Chatpot version dev-$version";
    return "Chatpot version dev-$version";
  }

  String get darkMode {
    if (language == 'ko') return '어두운 화면';
    else if (language == 'ja') return 'ダークモード';
    return 'Dark mode';
  }

  String get modeChangedDescription {
    if (language == 'ko') return '''색상 설정이 변경되었습니다.
변경된 설정은 앱을 재시작 하면 적용됩니다.''';
    else if (language == 'ja') return '''アプリの色設定が変更されました。
変更した設定はアプリを再起動すると有効になります。''';
    return '''The app color setting has been changed.
The changed settings will take effect when you restart the app.''';
  }
}
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

  String get description {
    if (language == 'ko') return '''로그인에 사용하는 비밀번호를 변경합니다.
기존 비밀번호와 지금부터 사용할 새로운 패스워드를 입력해 주세요.''';
    else if (language == 'ja') return '''サインインに使用するパスワードを変更する
既存のパスワードと今後使用する新しいパスワードを入力してください。''';
    return '''Change the password you use to sign in.
Please enter your existing password and a new password to use from now on.''';
  }

  String get oldPasswordPlaceholder {
    if (language == 'ko') return '''기존 비밀번호''';
    else if (language == 'ja') return '''以前のパスワード''';
    return '''Previous password''';   
  }

  String get newPasswordPlaceholder {
    if (language == 'ko') return '''새 비밀번호''';
    else if (language == 'ja') return '''新しいパスワード''';
    return '''New password''';   
  }

  String get newPasswordConfirmPlaceholder {
    if (language == 'ko') return '''새 비밀번호 확인''';
    else if (language == 'ja') return '''新しいパスワード確認''';
    return '''New password confirmation''';
  }
}
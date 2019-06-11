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

  String get changeButtonLabel {
    if (language == 'ko') return '비밀번호 변경';
    else if (language == 'ja') return 'パスワードを変更する';
    return 'Change password';
  }

  String get passwordRequired {
    if (language == 'ko') return '비밀번호를 입력해야 합니다.';
    else if (language == 'ja') return 'パスワードを入力してください。';
    return 'You must enter your password.';
  }

  String get previousPasswordRequired {
    if (language == 'ko') return '기존 비밀번호를 입력해야 합니다.';
    else if (language == 'ja') return '以前のパスワードを入力してください。';
    return 'You must enter your previous password.';
  }

  String get passwordNotMatch {
    if (language == 'ko') return '두 비밀번호가 일치하지 않습니다.';
    else if (language == 'ja') return 'パスワードが一致していません。';
    return 'Passwords do not match.';
  }

  String get previousPasswordWrong {
    if (language == 'ko') return '기존 비밀번호가 입력한 비밀번호와 일치하지 않습니다.';
    else if (language == 'ja') return '以前のパスワードが、入力したパスワードと一致しません。';
    return 'Previous password does not match the password you entered.';
  }

  String get passwordChangeCompleted {
    if (language == 'ko') return '비밀번호 변경이 완료되었습니다.';
    else if (language == 'ja') return 'パスワードは正常に変更されました。';
    return 'Your password changed successfully.';
  }
}
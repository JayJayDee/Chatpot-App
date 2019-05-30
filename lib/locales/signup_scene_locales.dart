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

  String get description {
    if (language == 'ko') return "회원가입을 위해 이메일과 비밀번호를 입력해 주세요.";
    else if (language == 'ja') return '登録するメールアドレスとパスワードを入力してください。';
    return 'Please enter your email and password to sign up.';
  }

  String get emailPlaceHolder {
    if (language == 'ko') return '이메일';
    else if (language == 'ja') return '電子メール';
    return 'Email';
  }

  String get passwordPlaceHolder {
    if (language == 'ko') return '비밀번호';
    else if (language == 'ja') return 'パスワード';
    return 'Password';
  }

  String get passworConfirmPlaceHolder {
    if (language == 'ko') return '비밀번호 확인';
    else if (language == 'ja') return 'パスワード確認';
    return 'Password confirm';
  }

  String get joinButton {
    if (language == 'ko') return '회원가입';
    else if (language == 'ja') return '登録';
    return 'Sign up';
  }

  String get emailRequired {
    if (language == 'ko') return '이메일을 입력해 주셔야 합니다.';
    else if (language == 'ja') return 'メールアドレスを入力してください。';
    return 'You must enter an email.';
  }

  String get passwordRequired {
    if (language == 'ko') return '비밀번호를 입력해 주셔야 합니다.';
    else if (language == 'ja') return 'パスワードを入力してください。';
    return 'You must enter your password.';
  }

  String get passwordNotMatch {
    if (language == 'ko') return '비밀번호가 일치하지 않습니다.';
    else if (language == 'ja') return 'パスワードが一致していません。';
    return 'Passwords do not match.';
  }
}
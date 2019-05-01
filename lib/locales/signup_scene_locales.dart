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
    if (language == 'ko') return '비밀번호';
    else if (language == 'ja') return 'パスワード';
    return 'Password';
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class LoginSceneLocales {
  String language;
  RootLocaleConverter root;

  LoginSceneLocales ({
      this.language,
      this.root
  });

  String get title {
    if (this.language == 'ko') return '로그인';
    else if (this.language == 'ja') return 'ログイン';
    return 'Sign in';
  }

  String get simpleSignupButton {
    if (this.language == 'ko') return '회원가입 없이 바로 시작!';
    else if (this.language == 'ja') return '申し込みなしで開始';
    return 'Start without signup';
  }

  String get loginIntroduce {
    if (this.language == 'ko') {
      return "";
    } else if (this.language == 'ja') {
      return "";
    }
    return "Please sign in for using Chatpot.\nOr, you can just start Chatpot without sign up.";
  }

  String get signInButton {
    if (this.language == 'ko') return '로그인';
    else if (this.language == 'ja') return ''; // TODO: japanese-locale must be supplied
    return 'Sign in';
  }

  String get signupButton {
    if (this.language == 'ko') return 'Email로 회원가입';
    else if (this.language == 'ja') return ''; // TODO: japanese-locale must be supplied
    return 'Sign up with email';
  }
}
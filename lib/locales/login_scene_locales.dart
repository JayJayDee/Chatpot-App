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
    else if (this.language == 'ja') return '登録なしで開始';
    return 'Start without signup';
  }

  String get loginIntroduce {
    if (this.language == 'ko') {
      return """Chatpot을 이용하기 위해서는 로그인이 필요합니다.
혹은, 회원가입 없이 바로 시작하실 수도 있습니다.
      """;
    } else if (this.language == 'ja') {
      return """Chatpotを使用するにはログインが必要です。
または、登録せずにChatpotを使用することもできます。""";
    }
    return "Please sign in for using the Chatpot.\nOr, you can just start the Chatpot without sign up.";
  }

  String get signInButton {
    if (this.language == 'ko') return '로그인';
    else if (this.language == 'ja') return 'ログイン';
    return 'Sign in';
  }

  String get signupButton {
    if (this.language == 'ko') return 'Email로 회원가입';
    else if (this.language == 'ja') return 'メールアカウントで登録';
    return 'Sign up with email';
  }

  String get emailHint {
    if (this.language == 'ko') return 'Email 주소';
    else if (this.language == 'ja') return '電子メールアドレス';
    return 'Email address';
  }

  String get passwordHint {
    if (this.language == 'ko') return '패스워드';
    else if (this.language == 'ja') return 'パスワード';
    return 'Password';
  }

  String get emailRequired {
    if (this.language == 'ko') return '이메일 주소를 입력하셔야 합니다.';
    else if (this.language == 'ja') return 'メールアドレスを入力してください。';
    return 'You must enter an email address.';
  }

  String get passwordRequired {
    if (this.language == 'ko') return '이메일 주소를 입력하셔야 합니다.';
    else if (this.language == 'ja') return 'パスワードを入力してください。';
    return 'You must enter your password.';
  }

  String get withoutSignupButtonLabel {
    if (this.language == 'ko') return '회원가입 없이 바로 시작!';
    else if (this.language == 'ja') return '登録せずに今すぐ始める';
    return 'Start now without signing up';
  }
}
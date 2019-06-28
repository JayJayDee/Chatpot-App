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

  String get genderRequired {
    if (language == 'ko') return '성별을 선택해 주세요.';
    else if (language == 'ja') return 'あなたの性別を選択してください。';
    return 'Please select your gender';
  }

  String get passwordNotMatch {
    if (language == 'ko') return '비밀번호가 일치하지 않습니다.';
    else if (language == 'ja') return 'パスワードが一致していません。';
    return 'Passwords do not match.';
  }

  String get passwordTooShort {
    if (language == 'ko') return '비밀번호가 너무 짧습니다. 6자 이상으로 만들어 주세요.';
    else if (language == 'ja') return 'パスワードが短すぎます。 6文字以上にしてください。';
    return 'The password is too short. Please make it more than 6 characters.';
  }

  String get genderChooserLabel {
    if (language == 'ko') return '성별을 선택하세요 (옵션)';
    else if (language == 'ja') return '性別を選択してください（オプション）';
    return 'Select your gender (Optional)';
  }

  String get genderMale {
    if (language == 'ko') return '남성';
    else if (language == 'ja') return '男性';
    return 'Male';
  }

  String get genderFemale {
    if (language == 'ko') return '여성';
    else if (language == 'ja') return '女性';
    return 'Female';
  }

  String get genderNothing {
    if (language == 'ko') return '알려주고 싶지 않습니다.';
    else if (language == 'ja') return '知らせたくない。';
    return 'I do not want to let you know.';
  }
  
  String get signupCompleted {
    if (language == 'ko') return '''회원 가입이 완료되었습니다.
가입한 이메일로 로그인 해주세요.
''';
    else if (language == 'ja') return '''申し込みは完了です。
メールでサインインしてください。''';
    return '''Sign up is complete.
Please sign in with your email.
''';
  }
}
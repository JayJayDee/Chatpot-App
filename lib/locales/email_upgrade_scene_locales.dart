import 'package:chatpot_app/locales/root_locale_converter.dart';

class EmailUpgradeSceneLocales {
  String language;
  RootLocaleConverter root;

  EmailUpgradeSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '이메일 계정 연결';
    else if (language == 'ja') return 'メールアカウントを登録';
    return 'Connect an email account';
  }

  String get emailInput {
    if (language == 'ko') return '이메일 계정을 현재 로그인한 계정에 연결합니다. 이메일을 입력하세요. 입력한 이메일은 다음 로그인부터 사용가능합니다.';
    else if (language == 'ja') return 'メールアカウントを現在ログインしているアカウントに接続します。 あなたのメールアドレスを入力してください。 入力したメールアドレスは次回のログインから利用可能になります。';
    return "Connecting your email account to the account you're currently signed in. The email you entered will be available from the next login.";
  }

  String get emailButtonLabel {
    if (language == 'ko') return '인증 이메일 발송';
    else if (language == 'ja') return '登録メールを送る';
    return "Send an activation email";
  }

  String codeInput(String email) {
    if (language == 'ko') return "입력한 이메일($email)로 인증 메일을 발송했습니다. 하단의 입력 란에 인증 메일 내에 있는 코드를 입력하세요. 또는 이메일 내에 존재하는 링크를 클릭하여 인증 절차를 완료 할 수도 있습니다.";
    else if (language == 'ja') return "入力したメールアドレス($email)に確認メールが送信されました。 下の欄に確認メールのコードを入力してください。 または、電子メール内にあるリンクをクリックして確認プロセスを完了することもできます。";
    return "We have sent a verification email to the email you entered ($email). Enter the code in the verification email in the field below. Alternatively, you can complete the verification process by clicking the link that exists within the email.";
  }

  String get codePlaceHolder {
    if (language == 'ko') return '인증 코드';
    else if (language == 'ja') return '適用する';
    return "Activation code";
  }

  String get codeInputButtonLabel {
    if (language == 'ko') return '제출';
    else if (language == 'ja') return '適用する';
    return "Submit"; 
  }

  String get codeResendButtonLabel {
    if (language == 'ko') return '메일 재전송';
    else if (language == 'ja') return 'メールを再送信';
    return "Resend an email"; 
  }

  String completed(String email) {
    if (language == 'ko') return "이메일 인증이 완료되었습니다. 지금부터 다른 Android, IOS 기기, 웹 페이지에서 제공하는 Chatpot 서비스에서 $email 주소로 로그인 하실 수 있습니다.";
    else if (language == 'ja') return "メールの確認は完了しました。 これからは、他のAndroidおよびIOSデバイスで$emailにサインインできます。";
    return "Your email verification is complete. From now on, you can sign in to $email on other Android and IOS devices, web page.";
  }

  String get completed2 {
    if (language == 'ko') return '확인 버튼을 클릭하여 로그아웃하고 이메일 계정으로 새로 로그인해 주세요.';
    else if (language == 'ja') return '[OK]ボタンをクリックしてサインアウトし、新しいメールアカウントでサインインします。';
    return 'Click the OK button to sign out and sign in with your new email account.';
  }

  String get completeOkButtonLabel {
    if (language == 'ko') return '확인';
    else if (language == 'ja') return 'Ok';
    return "Ok";
  }

  String get emailRequired {
    if (language == 'ko') return '이메일을 입력하세요.';
    else if (language == 'ja') return 'あなたはEメールを入力する必要があります。';
    return 'You need to enter an email.';
  }

  String get passwordInput {
    if (language == 'ko') return '앞으로의 로그인에 사용할 비밀번호를 입력하세요.';
    else if (language == 'ja') return '今後のサインイン用にパスワードを入力してください。';
    return 'Please enter a password for future sign-in.';
  }

  String get passwordPlaceholder {
    if (language == 'ko') return '비밀번호';
    else if (language == 'ja') return 'パスワード';
    return 'Password';
  }

  String get passwordConfirmPlaceholder {
    if (language == 'ko') return '비밀번호 확인';
    else if (language == 'ja') return 'パスワード確認';
    return 'Password confirmation';
  }

  String get passwordRequired {
    if (language == 'ko') return '비밀번호를 입력해야 합니다.';
    else if (language == 'ja') return 'パスワードを入力してください。';
    return 'You must enter your password.';
  }

  String get passwordNotMatch {
    if (language == 'ko') return '두 비밀번호가 일치하지 않습니다.';
    else if (language == 'ja') return 'パスワードが一致していません。';
    return 'Passwords do not match.';
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class SimpleSignupSceneLocales {
  String language;
  RootLocaleConverter root;

  SimpleSignupSceneLocales ({
      this.language,
      this.root
  });

  String get title {
    if (this.language == 'ko') return '회원가입 없이 바로 시작하기';
    else if (this.language == 'ja') return '登録せずに開始';
    return 'Start without signing up';
  }

  String get description {
    if (this.language == 'ko') {
      return '''복잡한 회원 가입 없이 바로 시작할 수 있습니다.
이메일 주소로 가입하는 것은 다른 기기나 웹페이지에서 Chatpot을 이용할 수 있게 해 줍니다.
걱정하지 마세요, 회원가입 없이 시작하더라도 나중에 언제든지 이메일을 추가 할 수 있습니다.''';
    } else if (this.language == 'ja') {
      return '''複雑なメンバーシップなしですぐに始めることができます。
電子メールアドレスでサインアップすると、他のデバイスまたはWebページでChatpotを使用することができます。
申し込まずに始めても心配しないで、後でいつでもメールを追加できます。''';
    }
    return '''You can start right away without complicated signing up.

Signing up with an email address allows you to use Chatpot on other devices or web pages.

Don't worry, even if you start without signing up, you can always add emails later.''';
  }

  String get genderRequired  {
    if (language == 'ko') return '성별을 선택해 주세요.';
    else if (language == 'ja') return 'あなたの性別を選択してください。';
    return 'Please select your gender';
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class WelcomeOobeDialogLocales {
  String language;
  RootLocaleConverter root;

  WelcomeOobeDialogLocales({
    this.language,
    this.root
  });

  String get page1Title {
    if (language == 'ko') return 'Chatpot에 오신것을 환영합니다!';
    else if (language == 'ja') return 'Chatpotへようこそ！';
    return 'Welcome to the Chatpot!';
  }

  String get page1ItsYou {
    if (language == 'ko') return '''안녕하세요!
다음은 당신만을 위해 만든
아바타예요!''';
    else if (language == 'ja') return '''こんにちは、
これは私たちが作ったアバターです。
貴方のために！''';
    return '''Hello!
Following is an avatar that we made,
Just for you!''';
  }

  String get page1ItsYouPrefix {
    if (language == 'ko') return '그리고 지금부터, 당신의 이름은';
    else if (language == 'ja') return 'そしてこれから、あなたの名前は:';
    return 'And from now on, your name is:';
  }

  String get page1ItsYouPostfix {
    if (language == 'ko') return '입니다.';
    else if (language == 'ja') return 'です。';
    return '';
  }

  String get nextButton {
    if (language == 'ko') return '네, 시작합시다!';
    else if (language == 'ja') return 'さあ、始めましょう！';
    return 'Okay, Let\'s start!';
  }
}
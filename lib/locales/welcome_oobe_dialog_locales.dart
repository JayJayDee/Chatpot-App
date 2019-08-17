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
    if (language == 'ko') return '''당신만을 위해 만든
아바타예요!''';
    else if (language == 'ja') return 'これはあなたのためだけに作ったアバターです！';
    return '''This is avatar that we made,
just for you!''';
  }

  String get nextButton {
    if (language == 'ko') return '네, 시작합시다!';
    else if (language == 'ja') return 'さあ、始めましょう！';
    return 'Okay, Let\'s start!';
  }
}
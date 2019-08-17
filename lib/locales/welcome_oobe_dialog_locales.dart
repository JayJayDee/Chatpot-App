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
    if (language == 'ko') return '다음은 당신입니다.';
    else if (language == 'ja') return 'Chatpotへようこそ！';
    return 'Welcome to the Chatpot!';
  }
}
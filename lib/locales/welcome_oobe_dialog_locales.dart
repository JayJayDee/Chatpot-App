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

  String get page2Desc1 {
    if (language == 'ko') return '''이름과 아바타를 번경할 수 있습니다. 설정 > 프로필 변경 버튼을 클릭하세요.''';
    else if (language == 'ja') return '[設定]> [プロフィールの編集]メニューで名前またはアバターを変更できます。';
    return '''You can change your name or avatar at Settings > Edit profile menu.''';
  }

  String get page3Desc1 {
    if (language == 'ko') return '''화면이 너무 밝으신가요? 어두운 화면 모드를 사용해 보세요!
세팅 메뉴 > 어두운 화면 모드 항목에서 찾아보실 수 있습니다.''';
    else if (language == 'ja') return '''画面が明るすぎますか？ ダークスクリーンモードをお試しください！
これは、[設定]メニュ > [ダークモード]で確認できます。''';
    return '''Is your screen too bright? Try dark screen mode!
This can be found in the Settings menu > Dark mode.''';
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class AboutSceneLocales {
  String language;
  RootLocaleConverter root;

  AboutSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return 'Chatpot에 대하여';
    else if (language == 'ja') return 'Chatpotについて';
    return 'About Chatpot';
  }

  String get greetings1 {
    if (language == 'ko') {
      return '''Chatpot은 전세계 사용자들 간의 실시간 번역 채팅을 위해 만들어진 서비스입니다.
서비스가 마음에 드신다면, 커피나 맥주 한잔 사주세요 :)''';
    } else if (language == 'ja') { 
      return '''Chatpotは、世界中のユーザー間での翻訳チャット用に設計されたサービスです。
あなたがサービスが好きなら、コーヒーやビールのカップを寄付してください:)''';
    }
    return '''The Chatpot is a service designed for translation chat among users around the world.
If you like the Chatpot, please donate a cup of coffee or beer :)''';
  }

  String get bitcoinDonateBtnLabel {
    if (language == 'ko') return '비트코인으로 기부하기';
    else if (language == 'ja') return 'Bitcoinで寄付する';
    return 'Donate via Bitcoin';
  }

  String get ethereumDonateBtnLabel {
    if (language == 'ko') return '이더리움으로 기부하기';
    else if (language == 'ja') return 'Ethereumから寄付する';
    return 'Donate via Ethereum';
  }

  String get bitcoinAddrCopyCompleted {
    if (language == 'ko') return '''비트코인 지갑 주소가 클립보드에 복사되었습니다.
기부에 감사드립니다!''';
    else if (language == 'ja') return '''Bitcoinウォレットアドレスがクリップボードにコピーされました。
ご寄付いただきありがとうございます。''';
    return '''The Bitcoin wallet address has been copied to the clipboard.
Thank you for your donation!''';
  }

  String get ethereumAddrCopyCompleted {
    if (language == 'ko') return '''이더리움 지갑 주소가 클립보드에 복사되었습니다.
기부에 감사드립니다!''';
    else if (language == 'ja') return '''Ethereumウォレットアドレスがクリップボードにコピーされました。
ご寄付いただきありがとうございます。''';
    return '''The Ethereum wallet address has been copied to the clipboard.
Thank you for your donation!''';
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class HomeSceneLocales {
  String language;
  RootLocaleConverter root;

  HomeSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '라운지';
    else if (language == 'ja') return 'ラウンジ';
    return 'Lounge';
  }

  String get recentChatHeader {
    if (language == 'ko') return '최근 채팅들';
    else if (language == 'ja') return '最近のチャット';
    return 'Recent chats';
  }

  String get crowdedChatHeader {
    if (language == 'ko') return '사람이 많은 채팅들';
    else if (language == 'ja') return '混雑したチャット';
    return 'Most crowded chats';
  }

  String get moreChat {
    if (language == 'ko') return '더 보기';
    else if (language == 'ja') return 'もっとチャット';
    return 'More chats..';
  }

  String get joinChat {
    if (language == 'ko') return '채팅방 입장';
    else if (language == 'ja') return 'チャットに入る';
    return 'Join to chat';
  }

  String get cancelChat {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return '取消';
    return 'Cancel';
  }

  String get newChatChooserTitle {
    if (language == 'ko') return '새 채팅 종류 선택';
    else if (language == 'ja') return 'チャットの種類を選択';
    return 'Choose a chat type';
  }

  String get publicTitle {
    if (language == 'ko') return '공개 채팅';
    else if (language == 'ja') return '公開チャット';
    return 'Public chat';
  }

  String get publicDesc {
    if (language == 'ko') return '대화 주제를 가지고 여러 사람과 채팅합니다.';
    else if (language == 'ja') return '会話をテーマにしている多くの人とチャットしましょう。';
    return 'Chat with many people who have a conversation theme.';
  }

  String get ranchatTitle {
    if (language == 'ko') return '랜덤 채팅';
    else if (language == 'ja') return 'ランダムチャット';
    return 'Chat roulette';
  }

  String get ranchatDesc {
    if (language == 'ko') return '''랜덤한 사람과 1:1 채팅을 시작합니다.''';
    else if (language == 'ja') return 'ランダムな人と1：1のチャットを始めます。';
    return '''Start a 1: 1 chat with a random person.''';
  }

  String get cancel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return '取消';
    return 'Cancel';
  }
}
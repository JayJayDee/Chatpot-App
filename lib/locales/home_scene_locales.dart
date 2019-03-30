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
}
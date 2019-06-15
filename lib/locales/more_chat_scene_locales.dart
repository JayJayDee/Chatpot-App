import 'package:chatpot_app/locales/root_locale_converter.dart';

class MoreChatSceneLocales {
  String language;
  RootLocaleConverter root;

  MoreChatSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '채팅 더 보기';
    else if (language == 'ja') return 'もっとチャット';
    return 'More chats';
  }

  String get orderPeopleDesc {
    if (language == 'ko') return '사람 많은 순서';
    else if (language == 'ja') return '人数で並べ替え';
    return 'sort by number of people';
  }

  String get orderRecentDesc {
    if (language == 'ko') return '최신순';
    else if (language == 'ja') return '最近の並べ替え';
    return 'sort by recent';
  }

  String get queryEditPlaceholder {
    if (language == 'ko') return '검색어';
    else if (language == 'ja') return '検索語';
    return 'Search keyword';
  }

  String get searchButtonLabel {
    if (language == 'ko') return '검색';
    else if (language == 'ja') return '検索';
    return 'Search';
  }
}
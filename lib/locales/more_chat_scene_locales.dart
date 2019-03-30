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
}
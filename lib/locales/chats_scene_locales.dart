import 'package:chatpot_app/locales/root_locale_converter.dart';

class ChatsSceneLocales {
  String language;
  RootLocaleConverter root;

  ChatsSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '내 채팅';
    else if (language == 'ja') return '私のチャット';
    return 'Chats';
  }
}
import 'package:chatpot_app/locales/root_locale_converter.dart';

class RoomDetailSceneLocales {
  String language;
  RootLocaleConverter root;

  RoomDetailSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '채팅방 상세';
    else if (language == 'ja') return 'チャットの詳細';
    return 'Chat details';
  }
}
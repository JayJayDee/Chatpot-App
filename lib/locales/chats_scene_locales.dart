import 'package:chatpot_app/locales/root_locale_converter.dart';
import 'package:chatpot_app/entities/member.dart';

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

  String get emptyRooms {
    if (language == 'ko') {
      return '''참여한 채팅방이 없습니다.
라운지에서 채팅방을 선택하거나
새로운 채팅방을 개설하세요.''';
    } else if (language == 'ja') {
      return '''チャットルームがありません。
ラウンジで部屋を選ぶ
または、新しいチャットを開くこともできます。''';
    }
    return '''You have no chat rooms.
Select a room in the Lounge,
Or you can open a new chat.''';
  }

  String rouletteTitle(Nick nick) {
    if (language == 'ko') return "${root.getNick(nick)}님과의 랜덤채팅";
    else if (language == 'ja') return "${root.getNick(nick)}さんのランダムチャット";
    return "Roulette chat with ${root.getNick(nick)}";
  }
}
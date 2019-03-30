import 'package:chatpot_app/locales/root_locale_converter.dart';

class MessageSceneLocales {
  String language;
  RootLocaleConverter root;

  MessageSceneLocales({
    this.language,
    this.root
  });

  String get leave {
    if (language == 'ko') return '나가기';
    else if (language == 'ja') return '去る';
    return 'Leave';
  }

  String get cancel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return '取消';
    return 'Cancel';
  }

  String get leaveDialogTitle {
    if (language == 'ko') return '채팅 나가기';
    else if (language == 'ja') return 'チャットから離れる';
    return 'Leaving from chat';
  }

  String get leaveDialogText {
    if (language == 'ko') return '정말로 이 채팅방에서 나가시겠습니까?';
    else if (language == 'ja') return 'このチャットを離れますか？';
    return 'Are you sure you want to leave this chat?';
  }
}
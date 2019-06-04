import 'package:chatpot_app/locales/root_locale_converter.dart';

class NewChatSceneLocales {
  String language;
  RootLocaleConverter root;

  NewChatSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '새 채팅';
    else if (language == 'ja') return '新しいチャット';
    return 'New chat';
  }

  String get header {
    if (language == 'ko') return "새로운 채팅을 개설합니다.\n\n다른 사람들이 채팅방의 제목에 불쾌감을 느끼지 않도록 주의해주세요.\n";
    else if (language == 'ja') return '新しいチャットを開設します。';
    return 'Creates a new chat.';
  }

  String get placeHolderTitle {
    if (language == 'ko') return '채팅 제목';
    else if (language == 'ja') return 'チャットタイトル';
    return 'Chat title';
  }

  String get placeHolderMaxAttendee {
    if (language == 'ko') return '채팅방 최대 인원 (2 ~ 10)';
    else if (language == 'ja') return 'チャット最大人数（2〜10)';
    return 'Maximum number of members (2 ~ 10)';
  }

  String get buttonCreate {
    if (language == 'ko') return '만들기';
    else if (language == 'ja') return '作成';
    return 'Create';
  }

  String get roomTitleRequired {
    if (language == 'ko') return '방 제목을 입력하셔야 합니다.';
    else if (language == 'ja') return '部屋のタイトルが必要です。';
    return 'Room title is required.';
  }

  String get maximunAttendeeRequired {
    if (language == 'ko') return '방 제목을 입력하셔야 합니다.';
    else if (language == 'ja') return '最大参加者数を入力する必要があります。';
    return 'You must enter a maximum number of participants.';
  }
}
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
    if (language == 'ko') return '''새로운 채팅방을 개설합니다.
채팅 제목은 자동으로 번역되므로 모국어로 작성해 주세요.
다른 사람들이 불쾌감을 느끼지 않을 제목으로 작성 부탁드립니다.''';
    else if (language == 'ja') return '新しいチャットを開設します。';
    return '''Open a new chat room.
Chat titles are automatically translated and should be written in your native language.
I would appreciate it written in a title that others would not feel offended.''';
  }

  String get placeHolderTitle {
    if (language == 'ko') return '채팅 제목';
    else if (language == 'ja') return 'チャットタイトル';
    return 'Subject of chat room';
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
    if (language == 'ko') return '최대 참여자 수를 입력하셔야 합니다.';
    else if (language == 'ja') return '最大参加者数を入力する必要があります。';
    return 'You must enter a maximum number of participants.';
  }

  String get invalidMaximumAttendees {
    if (language == 'ko') return '최대 참여자 수는 숫자만 입력 가능합니다.';
    else if (language == 'ja') return '参加者の最大数は数字のみです。';
    return 'The maximum number of participants can only be numeric.';
  }
}
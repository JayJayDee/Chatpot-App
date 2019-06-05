import 'package:chatpot_app/locales/root_locale_converter.dart';

class ErrorMessageLocales {
  String language;
  RootLocaleConverter root;

  ErrorMessageLocales({
    this.language,
    this.root
  });

  String messageFromErrorCode(String code) {
    if (code == 'ROOM_MAXIMUM_EXCEED') return this.maximumAttendeeExceeded;
    else if (code == 'ROOM_ALREADY_JOINED') return this.roomAlreadyJoined;
    else if (code == 'DUPLICATED_ENTRY') return this.duplicatedEmail;
    return uncatchedCode(code);
  }

  String get roomAlreadyJoined {
    if (language == 'ko') return '이미 참여한 채팅방입니다.';
    else if (language == 'ja') return 'もうチャットルームです。';
    return "It's already been my chat room.";
  }

  String get maximumAttendeeExceeded {
    if (language == 'ko') return '이미 채팅방의 최대 인원수에 도달하였습니다.';
    else if (language == 'ja') return 'すでに最大参加人数に達しています。';
    return "The room you selected has reached the maximum number of attendees";
  }

  String get duplicatedEmail {
    if (language == 'ko') return '이미 사용중인 이메일 주소입니다';
    else if (language == 'ja') return '既に使用されている電子メールアドレス';
    return 'This email address is already in use';
  }

  String uncatchedCode(String code) {
    if (language == 'ko') return "알 수 없는 에러가 발생했습니다: $code";
    else if (language == 'ja') return "不明なエラーが発生しました：$code";
    return "An unknown error occurred: $code";
  }
}
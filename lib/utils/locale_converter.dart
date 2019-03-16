import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/message.dart';

class LocaleConverter {
  String _language;

  void selectLanguage(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
  }

  String getNick(Nick nick) {
    if (_language == 'ko') return nick.ko;
    else if (_language == 'ja') return nick.ja;
    return _convertNickEnOnly(nick.en);
  }

  String _convertNickEnOnly(String enNick) =>
    enNick.split(' ')
      .map((String token) => '${token[0].toUpperCase()}${token.substring(1)}')
      .join(' ');

  String roomSubtitle(Room room) {
    String ownerNick = getNick(room.owner.nick);
    int remain = room.numAttendee - 1;
    if (_language == 'ko') {
      if (remain == 0) return "$ownerNick님 혼자 있습니다.";
      return "$ownerNick님 외 $remain명";

    } else if (_language == 'en') {
      if (remain == 0) return "$ownerNick alone";
      return "$ownerNick and $remain others";

    } else if (_language == 'ja') {
      if (remain == 0) return "$ownerNickさんだけです。";
      return "$ownerNickさん他$remain人がいます。";
    }
    return '';
  }

  String myRoomSubtitle(MyRoom room) {
    String ownerNick = getNick(room.owner.nick);
    int remain = room.numAttendee - 1;
    if (_language == 'ko') {
      if (remain == 0) return "$ownerNick님 혼자 있습니다.";
      return "$ownerNick님 외 $remain명";

    } else if (_language == 'en') {
      if (remain == 0) return "$ownerNick alone";
      return "$ownerNick and $remain others";

    } else if (_language == 'ja') {
      if (remain == 0) return "$ownerNickさんだけです。";
      return "$ownerNickさん他$remain人がいます。";
    }
    return '';
  }

  String myRoomRecentMessage(Message lastMessage) {
    if (lastMessage == null) return emptyMessageInRoom();
    String nick = getNick(lastMessage.from.nick);
    return "$nick: ${lastMessage.getTextContent()}";
  }

  String emptyMessageInRoom() {
    if (_language == 'ko') return '채팅방 내 대화가  없습니다.';
    else if (_language == 'ko') return 'no messages in room';
    else if (_language == 'ja') return '部屋にメッセージはありません';
    return '';
  }
}
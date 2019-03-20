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
    return "${lastMessage.getTextContent()}";
  }

  String emptyMessageInRoom() {
    if (_language == 'ko') return '채팅방 내 대화가  없습니다.';
    else if (_language == 'en') return 'no messages in room';
    else if (_language == 'ja') return '部屋にメッセージはありません';
    return '';
  }

  String messageReceiveTime(DateTime dt) {
    int diff =
      ((DateTime.now().millisecondsSinceEpoch - dt.millisecondsSinceEpoch) / 1000) as int;
    if (diff < 60) {
      if (_language == 'ko') return "조금 전";
      else if (_language == 'en') return 'just now';
      else if (_language == 'ja') return 'ちょうど今';

    } else if (diff >= 60 && diff < 3600) {
      int min = diff / 60 as int;
      if (_language == 'ko') return "$min 분 전";
      else if (_language == 'en') return "$min minutes ago";
      else if (_language == 'ja') return "$min 分前";

    } else if (diff >= 3600 && diff <= 86400) {
      int hour = diff / 3600 as int;
      if (_language == 'ko') return "$hour 시간 전";
      else if (_language == 'en') return "$hour hours ago";
      else if (_language == 'ja') return "$hour 時間前";     

    } else {
      int day = diff / 86400 as int;
      if (_language == 'ko') return "$day 일 전";
      else if (_language == 'en') return "$day days ago";
      else if (_language == 'ja') return "$day 日前";     
    }
    return '';
  }
}
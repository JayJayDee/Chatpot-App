import 'package:intl/intl.dart';
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
      ((DateTime.now().millisecondsSinceEpoch - dt.millisecondsSinceEpoch) / 1000).round();

    if (diff < 60) {
      if (_language == 'ko') return "조금 전";
      else if (_language == 'en') return 'just now';
      else if (_language == 'ja') return 'ちょうど今';

    } else if (diff >= 60 && diff < 3600) {
      int min = (diff / 60).round();
      if (_language == 'ko') return "$min분 전";
      else if (_language == 'en') return "${min}minutes ago";
      else if (_language == 'ja') return "$min分前";

    } else if (diff >= 3600 && diff <= 86400) {
      int hour = (diff / 3600).round();
      if (_language == 'ko') return "$hour시간 전";
      else if (_language == 'en') return "${hour}hours ago";
      else if (_language == 'ja') return "$hour時間前";     

    } else {
      int day = (diff / 86400).round();
      if (_language == 'ko') return "$day일 전";
      else if (_language == 'en') return "${day}days ago";
      else if (_language == 'ja') return "$day日前";     
    }
    return '';
  }

  String toDateTime(DateTime dt) {
    DateFormat formatter;
    if (_language == 'ko') formatter = DateFormat('yyyy년 M월 d일 hh시 mm분 ss초');
    else if (_language == 'ja') formatter = DateFormat('yyyy年 M月 d日 hh時 mm分 ss秒');
    else formatter = DateFormat('MMMM d, yyyy hh:mm:ss');
    return formatter.format(dt);
  }

  String numMembersInRoom(List<Member> members) {
    Map<String, int> regionMap = Map();
    members.forEach((m) => regionMap[m.region] = 1);
    int numCountry = regionMap.keys.length;
    int numMember = members.length;
    if (_language == 'ko') return "$numCountry개 국가의 $numMember명이 채팅중!";
    else if (_language == 'ja') return "$numCountryカ国の$numMember人がチャット中です。";
    return "$numCountry people from $numMember countries are chatting";
  }

  AssetImage getFlagImage(String regionCode) {
    String lowered = regionCode.toLowerCase();
    String path = "assets/$lowered.png";
    return AssetImage(path);
  }
}
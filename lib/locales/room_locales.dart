import 'package:chatpot_app/locales/root_locale_converter.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/message.dart';

class RoomLocales {
  String language;
  RootLocaleConverter root;

  RoomLocales({
    this.language,
    this.root
  });

  String get translateLabel {
    if (language == 'ko') return '번역';
    else if (language == 'ja') return '翻訳';
    return 'Translation';
  }

  String getNick(Nick nick) {
    if (language == 'ko') return nick.ko;
    else if (language == 'ja') return nick.ja;
    return _convertNickEnOnly(nick.en);
  }

  String _convertNickEnOnly(String enNick) =>
    enNick.split(' ')
      .map((String token) => '${token[0].toUpperCase()}${token.substring(1)}')
      .join(' ');

  String roomSubtitle(Room room) {
    String ownerNick = getNick(room.owner.nick);
    int remain = room.numAttendee - 1;
    if (language == 'ko') {
      if (remain == 0) return "$ownerNick님 혼자 있습니다.";
      return "$ownerNick님 외 $remain명";

    } else if (language == 'en') {
      if (remain == 0) return "$ownerNick alone";
      return "$ownerNick and $remain others";

    } else if (language == 'ja') {
      if (remain == 0) return "$ownerNickさんだけです。";
      return "$ownerNickさん他$remain人がいます。";
    }
    return '';
  }

  String myRoomSubtitle(MyRoom room) {
    String ownerNick = getNick(room.owner.nick);
    int remain = room.numAttendee - 1;
    if (language == 'ko') {
      if (remain == 0) return "$ownerNick님 혼자 있습니다.";
      return "$ownerNick님 외 $remain명";

    } else if (language == 'en') {
      if (remain == 0) return "$ownerNick alone";
      return "$ownerNick and $remain others";

    } else if (language == 'ja') {
      if (remain == 0) return "$ownerNickさんだけです。";
      return "$ownerNickさん他$remain人がいます。";
    }
    return '';
  }

  String myRoomRecentMessage(Message lastMessage) {
    if (lastMessage == null) return emptyMessageInRoom();

    if (lastMessage.messageType == MessageType.TEXT) {
      return "${lastMessage.getTextContent()}";
    } else if (lastMessage.messageType == MessageType.IMAGE) {
      if (language == 'ko') return '(사진)';
      else if (language == 'ja') return '(写真)';
      else return '(Photo)';
    } else if (lastMessage.messageType == MessageType.NOTIFICATION) {
      return root.message.notificationText(lastMessage.getNotificationContent());
    }
    return '';
  }

  String emptyMessageInRoom() {
    if (language == 'ko') return '채팅방 내 대화가 없습니다.';
    else if (language == 'ja') return '部屋にメッセージはありません';
    return 'no messages in room';
  }

  String numMembersInRoom(List<Member> members) {
    Map<String, int> regionMap = Map();
    members.forEach((m) => regionMap[m.region] = 1);
    int numCountry = regionMap.keys.length;
    int numMember = members.length;
    if (language == 'ko') return "$numCountry개 국가의 $numMember명이 채팅중!";
    else if (language == 'ja') return "$numCountryカ国の$numMember人がチャット中です。";
    return "$numCountry people from $numMember countries are chatting";
  }

  String numMembersSimple(int numAttendee) {
    if (language == 'ko') return "$numAttendee명";
    else if (language == 'ja') return "$numAttendee人";
    return "$numAttendee people";
  }

  String roomTypeLabel(RoomType type) {
    if (type == RoomType.PUBLIC) return publicRoomLabel;
    else if (type == RoomType.ONEONONE) return oneOnOneRoomLabel;
    else if (type == RoomType.ROULETTE) return rouletteRoomLabel;
    return '';
  }

  String get publicRoomLabel {
    if (language == 'ko') return '공개 채팅';
    else if (language == 'ja') return '公開チャットルーム';
    return 'Public chats';
  }

  String get oneOnOneRoomLabel {
    if (language == 'ko') return '1:1 채팅';
    else if (language == 'ja') return '1：1チャット';
    return '1:1 chats';
  }

  String get rouletteRoomLabel {
    if (language == 'ko') return '랜덤 채팅';
    else if (language == 'ja') return 'ランダムなチャット';
    return 'Chat roulettes';
  }
}
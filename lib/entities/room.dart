import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/message.dart';

enum RoomType {
  PUBLIC, ROULETTE, ONEONONE
}

RoomType _getRoomType(String typeExpr) =>
  typeExpr == 'PUBLIC' ? RoomType.PUBLIC :
  typeExpr == 'ROULETTE' ? RoomType.ROULETTE :
  typeExpr == 'ONEONONE' ? RoomType.ONEONONE : null;

class Room {
  String roomToken;
  Member owner;
  String title;
  int numAttendee;
  int maxAttendee;
  DateTime regDate;
  String titleTranslated;
  RoomType type;

  Room() {
    titleTranslated = null;
  }

  factory Room.fromJson(Map<String, dynamic> map) {
    Room room = Room();
    room.roomToken = map['room_token'];
    room.title = map['title'];
    room.numAttendee = map['num_attendee'];
    room.maxAttendee = map['max_attendee'];
    room.owner = Member.fromJson(map['owner']);
    room.regDate = DateTime.parse(map['reg_date']);
    room.type = _getRoomType(map['room_type']);
    return room;
  }

  @override
  toString() => "$roomToken:$title";
}

class RoomDetail {
  String roomToken; 
  Member owner;
  String title;
  int numAttendee;
  int maxAttendee;
  DateTime regDate;
  List<Member> members;
  RoomType type;

  RoomDetail();

  factory RoomDetail.fromJson(Map<String, dynamic> map) {
    RoomDetail room = RoomDetail();
    room.roomToken = map['room_token'];
    room.title = map['title'];
    room.numAttendee = map['num_attendee'];
    room.maxAttendee = map['max_attendee'];
    room.owner = Member.fromJson(map['owner']);
    room.regDate = DateTime.parse(map['reg_date']);
    List<dynamic> memberList = map['members'];
    room.members = memberList.map((elem) => Member.fromJson(elem)).toList();
    room.type = _getRoomType(map['room_type']);
    return room;
  }

  @override
  toString() => "$roomToken:$title";
}

class MyRoom {
  String roomToken; 
  Member owner;
  String title;
  int numAttendee;
  int maxAttendee;
  DateTime regDate;
  Message lastMessage;
  String titleTranslated;
  RoomType type;
  RoomMessages messages;
  bool shown;
  Member rouletteOpponent;

  MyRoom() {
    messages = RoomMessages();
    this.shown = false;
  }

  factory MyRoom.fromJson(Map<String, dynamic> map) {
    MyRoom room = MyRoom();
    room.roomToken = map['room_token'];
    room.title = map['title'];
    room.numAttendee = map['num_attendee'];
    room.maxAttendee = map['max_attendee'];
    room.owner = Member.fromJson(map['owner']);
    room.regDate = DateTime.parse(map['reg_date']);
    if (map['last_message'] != null) {
      room.lastMessage = Message.fromJson(map['last_message']);
    }
    room.type = _getRoomType(map['room_type']);

    if (map['roulette_opponent'] != null) {
      room.rouletteOpponent = Member.fromJson(map['roulette_opponent']);
    }
    return room;
  }

  String get rouletteNumber {
    String sub = this.roomToken.substring(0, 6);
    int number = int.parse("0x$sub");
    return "#$number";
  }

  @override
  toString() => "$roomToken:$title";
}
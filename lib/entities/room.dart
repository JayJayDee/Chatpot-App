import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/message.dart';

class Room {
  String roomToken; 
  Member owner;
  String title;
  int numAttendee;
  int maxAttendee;
  DateTime regDate;
  String titleTranslated;

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
  Map<String, String> messageTranslated;

  RoomMessages messages;

  MyRoom() {
    messages = RoomMessages();
    messageTranslated = Map();
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
    return room;
  }

  String translatedMessage(String messageId) => messageTranslated[messageId];

  void cacheTranslation(String messageId, String translated) {
    messageTranslated[messageId] = translated;
  }

  @override
  toString() => "$roomToken:$title";
}
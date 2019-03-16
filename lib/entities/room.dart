import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/message.dart';

class Room {
  String roomToken; 
  Member owner;
  String title;
  int numAttendee;
  int maxAttendee;
  DateTime regDate;

  Room();

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

class MyRoom {
  String roomToken; 
  Member owner;
  String title;
  int numAttendee;
  int maxAttendee;
  DateTime regDate;
  Message lastMessage;

  RoomMessages messages;

  MyRoom() {
    messages = RoomMessages();
  }

  factory MyRoom.fromJson(Map<String, dynamic> map) {
    MyRoom room = MyRoom();
    room.roomToken = map['room_token'];
    room.title = map['title'];
    room.numAttendee = map['num_attendee'];
    room.maxAttendee = map['max_attendee'];
    room.owner = Member.fromJson(map['owner']);
    room.regDate = DateTime.parse(map['reg_date']);
    room.lastMessage = Message.fromJson(map['last_message']);
    return room;
  }

  @override
  toString() => "$roomToken:$title";
}
import 'package:chatpot_app/entities/member.dart';

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
}
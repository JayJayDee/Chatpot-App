import 'package:chatpot_app/entities/member.dart';

class Room {
  final String roomToken;
  final Member owner;
  final String title;
  final int numAttendee;
  final int maxAttendee;
  final DateTime regDate;

  Room({
    this.roomToken,
    this.owner,
    this.title,
    this.numAttendee,
    this.maxAttendee,
    this.regDate
  });
}
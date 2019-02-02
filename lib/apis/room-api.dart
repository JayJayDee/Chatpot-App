import 'package:chatpot_app/apis/request.dart';
import 'package:chatpot_app/entities/room.dart';

class ResRoomList {
  int all;
  int size;
  List<Room> list;
}

Function req = request('http://dev-room.chatpot.chat');

Future<ResRoomList> roomList({ String sessionKey }) async {
  var resp = await req('/rooms', RequestMethod.Get, body: {}, query: {
    'session_key': sessionKey
  });
  // TODO: must parse response.
  return null;
}
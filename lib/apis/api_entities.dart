import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/room.dart';

class SimpleJoinApiResp {
  Nick nick;
  String token;
  String passphrase;

  SimpleJoinApiResp();

  factory SimpleJoinApiResp.fromJson(Map<String, dynamic> map) {
    var res = SimpleJoinApiResp();
    res.nick = Nick.fromJson(map['nick']);
    res.token = map['token'];
    res.passphrase = map['passphrase'];
    return res;
  }

  @override
  toString() => "SIMPLEJOIN_API_RESP: $nick, $token";
}

class AuthApiResp {
  String sessionKey;

  AuthApiResp();

  factory AuthApiResp.fromJson(Map<String, dynamic> map) {
    var res = AuthApiResp();
    res.sessionKey = map['session_key'];
    return res;
  }

  @override
  toString() => "AUTH_API_RESP: $sessionKey";
}

class RoomListApiResp {
  int all;
  int size;
  List<Room> list;
  RoomListApiResp();
  
  factory RoomListApiResp.fromJson(Map<String, dynamic> map) {
    RoomListApiResp resp = RoomListApiResp();
    resp.all = map['all'];
    resp.size = map['size'];
    resp.list = [];

    List<dynamic> list = map['list'];
    List<Room> rooms = list.map((elem) => Room.fromJson(elem)).toList();
    resp.list = rooms;
    return resp;
  }
  @override
  toString() => "ROOM_API_RESP: $size $all";
}
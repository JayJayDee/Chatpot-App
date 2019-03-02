import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/entities/room.dart';

class RoomApi {
  Requester _requester;

  RoomApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<RoomListApiResp> requestPublicRooms() async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/rooms',
      method: HttpMethod.GET
    );
    return RoomListApiResp.fromJson(resp);
  }

  Future<void> requestRoomJoin({
    @required String roomToken,
    @required String memberToken
  }) async {
    await _requester.requestWithAuth(
      url: "/room/$roomToken/join",
      method: HttpMethod.POST,
      body: {
        'member_token': memberToken
      }
    );
  }

  Future<List<MyRoom>> requestMyRooms({
    @required String memberToken
  }) async {
    var resp = await _requester.requestWithAuth(
      url: "/my/$memberToken/rooms",
      method: HttpMethod.GET
    );
    List<dynamic> list = resp;
    List<MyRoom> myRooms = list.toList().map((elem) => MyRoom.fromJson(elem)).toList();
    return myRooms;
  }
}
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

  Future<FeaturedRoomsResp> requestFeaturedRooms() async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/rooms/featured',
      method: HttpMethod.GET
    );
    var ret = FeaturedRoomsResp.fromJson(resp);
    return ret;
  }

  Future<RoomListApiResp> requestPublicRooms({
    int offset,
    int size,
    String order
  }) async {
    Map<String, dynamic> qsMap = Map();
    if (offset != null) qsMap['offset'] = offset;
    if (size != null) qsMap['size'] = size;
    if (order != null) qsMap['order'] = order;

    Map<String, dynamic> resp = await _requester.request(
      url: '/rooms',
      method: HttpMethod.GET,
      qs: qsMap
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

  Future<void> requestRoomLeave({
    @required String roomToken,
    @required String memberToken
  }) async {
    await _requester.requestWithAuth(
      url: "/room/$roomToken/leave",
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

  Future<String> requestCreateRoom({
    @required String memberToken,
    @required String title,
    @required int maxAttendee
  }) async {
    var resp = await _requester.requestWithAuth(
      url: '/room',
      method: HttpMethod.POST,
      body: {
        'member_token': memberToken,
        'max_attendee': maxAttendee.toString(),
        'title': title
      }
    );
    Map<String, dynamic> respMap = resp;
    return respMap['room_token'];
  }
}
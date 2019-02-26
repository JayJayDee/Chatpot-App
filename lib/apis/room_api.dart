import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class RoomApi {
  Requester _requester;

  RoomApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<RoomListApiResp> requestRoomList() async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/rooms',
      method: HttpMethod.GET
    );
    return RoomListApiResp.fromJson(resp);
  }
}
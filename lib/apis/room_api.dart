import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class RoomApi {
  Requester _requester;

  RoomApi(Requester requester) {
    _requester = requester;
  }
}
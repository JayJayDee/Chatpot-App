import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/message.dart';

class JoinRoomResp {
  bool _success;
  String _cause;

  JoinRoomResp({
    @required bool success,
    String cause
  }) {
    _success = success;
    _cause = cause;
  }

  bool get success => _success;
  String get cause => _cause;
}
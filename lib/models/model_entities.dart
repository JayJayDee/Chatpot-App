import 'package:meta/meta.dart';

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

class QueuedTranslation {
  final String roomToken;
  final String from;
  final String message;
  final String messageId;

  QueuedTranslation({
    this.roomToken,
    this.from,
    this.message,
    this.messageId
  });
}

class EmailLoginResp {
  final String memberToken;
  final bool activated;

  EmailLoginResp({
    @required this.memberToken,
    @required this.activated
  });
}

enum BackgroundActionType {
  ROOM, REPORT
}

class BackgroundAction {
  final BackgroundActionType type;
  final String payload;

  BackgroundAction({
    @required this.type,
    @required this.payload
  });
}
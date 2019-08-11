import 'package:chatpot_app/entities/notification.dart';
import 'package:chatpot_app/entities/message.dart';

enum PushType {
  NOTIFICATION, MESSAGE
}

enum PushOrigin {
  FOREGROUND, BACKGROUND
}

class Push {
  PushType pushType;
  PushOrigin pushOrigin;
  Map<String, dynamic> _content;

  Push() {
    pushOrigin = PushOrigin.FOREGROUND;
  }

  dynamic getContent() {
    if (this.pushType == PushType.NOTIFICATION) {
      return PushNotification.fromJson(_content);
    }
    return Message.fromJson(_content);
  }

  factory Push.fromJson(Map<String, dynamic> map, PushOrigin origin) {
    Push resp = Push();
    resp.pushOrigin = origin;
    if (map['push_type'] == 'NOTIFICATION') resp.pushType = PushType.NOTIFICATION;
    else resp.pushType = PushType.MESSAGE;
    resp._content = map;
    return resp;
  }

  @override
  String toString() => "[PushInstance] $pushType $_content";
}
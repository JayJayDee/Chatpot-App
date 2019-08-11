enum PushNotificationType {
  CHAT_ROULLETE_MATCHED,
  CHAT_ROULETTE_DESTROYED
}

class PushNotification {
  PushNotificationType notificationType;
  Map<String, dynamic> _content;

  PushNotification();

  factory PushNotification.fromJson(Map<String, dynamic> map) {
    PushNotification resp = PushNotification();
    String typeExpr = map['type'];
    if (typeExpr == 'ROULETTE_MATCHED') {
      resp.notificationType = PushNotificationType.CHAT_ROULLETE_MATCHED;
    } else if (typeExpr == 'ROULETTE_DESTROYED') {
      resp.notificationType = PushNotificationType.CHAT_ROULETTE_DESTROYED;
    }
    resp._content = map;
    return resp;
  }

  dynamic getContent() {
    if (notificationType == PushNotificationType.CHAT_ROULLETE_MATCHED) {
      return RouletteMatchedNotification.fromJson(_content);
    } else if (notificationType == PushNotificationType.CHAT_ROULETTE_DESTROYED) {
      return RouletteDestroyedNotification.fromJson(_content);
    }
    return null;
  }

  @override
  String toString() =>
    "[NotificationInstance] $notificationType $_content";
}

class RouletteMatchedNotification {
  String roomToken;
  RouletteMatchedNotification();

  factory RouletteMatchedNotification.fromJson(Map<String, dynamic> map) {
    RouletteMatchedNotification resp = RouletteMatchedNotification();
    resp.roomToken = map['room_token'];
    return resp;
  }
}

class RouletteDestroyedNotification {
  String roomToken;
  RouletteDestroyedNotification();

  factory RouletteDestroyedNotification.fromJson(Map<String, dynamic> map) {
    RouletteDestroyedNotification resp = RouletteDestroyedNotification();
    resp.roomToken = map['room_token'];
    return resp;
  }
}
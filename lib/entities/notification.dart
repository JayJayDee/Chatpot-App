
enum NotificationType {
  CHAT_ROULLETE_MATCHED
}
class Notification {
  NotificationType notificationType;
  Notification();

  factory Notification.fromJson(Map<String, dynamic> map) {
    Notification resp = Notification();
    String typeExpr = map['type'];
    if (typeExpr == 'ROULETTE_MATCHED') {
      resp.notificationType = NotificationType.CHAT_ROULLETE_MATCHED;
    }
    return resp;
  }
}

class RouletteMatchedNotification extends Notification {
  String roomToken;
  RouletteMatchedNotification();

  factory RouletteMatchedNotification.fromJson(Map<String, dynamic> map) {
    RouletteMatchedNotification resp = RouletteMatchedNotification();
    resp.roomToken = map['room_token'];
    return resp;
  }
}
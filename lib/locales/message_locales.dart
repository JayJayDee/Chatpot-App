import 'package:chatpot_app/locales/root_locale_converter.dart';
import 'package:chatpot_app/entities/message.dart';

class MessageLocales {
  String language;
  RootLocaleConverter root;

  MessageLocales({
    this.language,
    this.root
  });

  String messageReceiveTime(DateTime dt) {
    int diff =
      ((DateTime.now().millisecondsSinceEpoch - dt.millisecondsSinceEpoch) / 1000).round();

    if (diff < 60) {
      if (language == 'ko') return "조금 전";
      else if (language == 'en') return 'just now';
      else if (language == 'ja') return 'ちょうど今';

    } else if (diff >= 60 && diff < 3600) {
      int min = (diff / 60).round();
      if (language == 'ko') return "$min분 전";
      else if (language == 'en') return "$min minutes ago";
      else if (language == 'ja') return "$min分前";

    } else if (diff >= 3600 && diff <= 86400) {
      int hour = (diff / 3600).round();
      if (language == 'ko') return "$hour시간 전";
      else if (language == 'en') return "$hour hours ago";
      else if (language == 'ja') return "$hour時間前";     

    } else {
      int day = (diff / 86400).round();
      if (language == 'ko') return "$day일 전";
      else if (language == 'en') return "$day days ago";
      else if (language == 'ja') return "$day日前";
    }
    return '';
  }

  String get translateLabel {
    if (language == 'ko') return '번역';
    else if (language == 'ja') return '翻訳';
    return 'Translation';
  }

  String notificationText(NotificationContent noti) {
    if (noti.notificationType == NotificationType.JOIN_ROOM) return _roomJoinText(noti);
    if (noti.notificationType == NotificationType.LEAVE_ROOM) return _roomLeaveText(noti);
    return ' ';
  }

  String _roomJoinText(NotificationContent noti) {
    String nick = root.getNick(noti.member.nick);
    if (language == 'ko') return "$nick님이 채팅에 참여했습니다.";
    else if (language == 'ja') return "$nickさんがチャットに参加しました。";
    return "The $nick has joined the chat.";
  }

  String _roomLeaveText(NotificationContent noti) {
    String nick = root.getNick(noti.member.nick);
    if (language == 'ko') return "$nick님이 채팅에서 나갔습니다.";
    else if (language == 'ja') return "$nickさんがチャットを離れました。";
    return "The $nick has left the chat.";
  }
}
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/member.dart';

class Message {
  String messageId;
  MessageType messageType;
  Member from;
  DateTime sentTime;
  dynamic content;

  Message();

  factory Message.fromJson(Map<String, dynamic> map) {
    Message message = Message();
    message.messageId = map['message_id'];
    message.messageType = _getType(map['type']);
    message.from = Member.fromJson(map['from']);
    message.sentTime = DateTime.fromMillisecondsSinceEpoch(map['sent_time']);
    message.content = map['content'];
    return message;
  }

  String getTextContent() {
    if (messageType != MessageType.TEXT) return null;
    return content;
  }

  ImageContent getImageContent() {
    if (messageType != MessageType.IMAGE) return null;
    return ImageContent.fromJson(content);
  }

  NotificationContent getNotificationContent() {
    if (messageType != MessageType.NOTIFICATION) return null;
    return null;
  }

  @override
  toString() => "MESSAGE($messageId): $content";
}

enum MessageType {
  TEXT, IMAGE, NOTIFICATION
}
MessageType _getType(String expr) {
  if (expr == 'TEXT') return MessageType.TEXT;
  else if (expr == 'IMAGE') return MessageType.IMAGE;
  else if (expr == 'NOTIFICATION') return MessageType.NOTIFICATION;
  return null;
}

class ImageContent {
  String imageUrl;
  String thumbnailUrl;

  ImageContent({
    @required this.imageUrl,
    @required this.thumbnailUrl
  }); 

  factory ImageContent.fromJson(Map<dynamic, String> map) =>
    ImageContent(
      imageUrl: map['profile_img'],
      thumbnailUrl: map['profile_thumb']
    );
}

class NotificationContent {

}

class RoomMessages {
  int _offset;
  List<Message> _messages;
  bool moreMessage;
  Map<String, int> _existMap;

  RoomMessages() {
    _offset = 0;
    _messages = List();
    moreMessage = true;
    _existMap = Map();
  }

  List<Message> get messages => _messages;
  int get offset => _offset;

  void clearOffset() {
    _offset = 0;
  }

  void appendMesasges(List<Message> newMessages) {
    newMessages.forEach((m) {
      if (_existMap[m.messageId] != null) return;
      _messages.insert(0, m); // TODO: think about message order.
      _existMap[m.messageId] = 1;
    });
    _offset += newMessages.length;
  }
}
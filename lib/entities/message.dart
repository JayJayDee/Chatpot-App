import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/member.dart';

class Message {
  String messageId;
  MessageType messageType;
  Member from;
  MessageTo to;
  DateTime sentTime;
  dynamic content;

  Message();

  factory Message.fromJson(Map<String, dynamic> map) {
    Message message = Message();
    message.messageId = map['message_id'];
    message.messageType = _getType(map['type']);
    message.from = Member.fromJson(map['from']);
    message.to =MessageTo.fromJson(map['to']);
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

class MessageTo {
  MessageTarget type;
  String token;

  MessageTo();

  factory MessageTo.fromJson(Map<String, dynamic> map) {
    MessageTo to = MessageTo();
    to.token = map['token'];
    to.type = _getTarget(map['type']);
    return to;
  }
}
enum MessageTarget {
  ROOM
}
MessageTarget _getTarget(String expr) {
  if (expr == 'ROOM') return MessageTarget.ROOM;
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
      imageUrl: map['image_url'],
      thumbnailUrl: map['thumb_url']
    );

  Map<dynamic, String> toJson() {
    Map<dynamic, String> resp = Map();
    resp['image_url'] = imageUrl;
    resp['thumb_url'] = thumbnailUrl;
    return resp;
  }
}

class NotificationContent {

}

class RoomMessages {
  int _offset;
  int _notViewed;
  List<Message> _messages;
  bool moreMessage;
  Map<String, int> _existMap;

  RoomMessages() {
    _offset = 0;
    _notViewed = 0;
    _messages = List();
    moreMessage = true;
    _existMap = Map();
  }

  List<Message> get messages => _messages;
  int get offset => _offset;
  int get notViewed => _notViewed;

  void clearOffset() {
    _offset = 0;
  }

  void clearNotViewed() {
    _notViewed = 0;
  }

  void increaseNotViewed() {
    _notViewed++;
  }

  void appendMesasges(List<Message> newMessages) {
    newMessages.reversed.toList().forEach((m) {
      if (_existMap[m.messageId] != null) return;
      _messages.add(m);
      _existMap[m.messageId] = 1;
    });
    _offset += newMessages.length;
  }

  void appendSingleMessage(Message msg) {
    _messages.add(msg);
    _existMap[msg.messageId] = 1;
  }
}
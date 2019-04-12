import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/member.dart';

enum AttchedImageStatus {
  REMOTE_IMAGE, LOCAL_IMAGE
}

class Message {
  String messageId;
  String translated;
  MessageType messageType;
  Member from;
  MessageTo to;
  DateTime sentTime;
  dynamic content;

  bool _isSending;

  AttchedImageStatus _attachedImageStatus;
  int _imageUploadProgress;

  Message() {
    _isSending = false;
    _attachedImageStatus = null;
    _imageUploadProgress = 0;
    _attachedImageStatus = AttchedImageStatus.REMOTE_IMAGE;
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    Message message = Message();
    message.messageId = map['message_id'];
    message.messageType = _getType(map['type']);
    message.from = Member.fromJson(map['from']);
    message.to = MessageTo.fromJson(map['to']);
    message.sentTime = DateTime.fromMillisecondsSinceEpoch(map['sent_time']);
    message.content = map['content'];
    return message;
  }

  bool get isSending => _isSending;
  int get attatchmentUploadProgress => _imageUploadProgress;
  void changeToSending() => _isSending = true;
  void changeToSent() => _isSending = false;

  AttchedImageStatus get attchedImageStatus => _attachedImageStatus;

  void changeToLocalImage(String imagePath) {
    _attachedImageStatus = AttchedImageStatus.LOCAL_IMAGE;
    Map<String, String> imageSrcMap = Map();
    imageSrcMap['image_url'] = imagePath;
    imageSrcMap['thumb_url'] = imagePath;
    this.content = imageSrcMap;
    _imageUploadProgress = 0;
  }

  void changeUploadProgress(int prog) => _imageUploadProgress = prog;

  void changeToRemoteImage({
    @required String imageUrl,
    @required String thumbUrl
  }) {
    _attachedImageStatus = AttchedImageStatus.REMOTE_IMAGE;
    Map<String, String> imageSrcMap = Map();
    imageSrcMap['image_url'] = imageUrl;
    imageSrcMap['thumb_url'] = thumbUrl;
    this.content = imageSrcMap;
  }

  String getTextContent() {
    if (messageType != MessageType.TEXT) return null;
    return content.toString();
  }

  ImageContent getImageContent() {
    if (messageType != MessageType.IMAGE) return null;
    if (content is ImageContent) return content;
    Map<String, dynamic> converted = Map.from(content);
    return ImageContent.fromJson(converted);
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

  factory ImageContent.fromJson(Map<String, dynamic> map) =>
    ImageContent(
      imageUrl: map['image_url'],
      thumbnailUrl: map['thumb_url']
    );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> resp = Map();
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
  List<Message> _queuedMessages;
  bool moreMessage;
  Map<String, int> _existMap;

  RoomMessages() {
    _offset = 0;
    _notViewed = 0;
    _messages = List();
    _queuedMessages = List();
    moreMessage = true;
    _existMap = Map();
  }

  List<Message> get messages => _messages;
  int get offset => _offset;
  int get notViewed => _notViewed;

  void clearOffset() {
    _offset = 0;
  }

  void clearMessages() {
    _existMap.clear();
    _messages.clear();
  }

  void clearNotViewed() {
    _notViewed = 0;
  }

  void increaseNotViewed() {
    _notViewed++;
  }

  void appendMesasges(List<Message> newMessages) {
    newMessages.forEach((m) {
      if (_existMap[m.messageId] != null) return;
      _messages.add(m);
      _existMap[m.messageId] = 1;
    });
    _offset += newMessages.length;
  }

  void appendQueuedMessage(Message msg) {
    _queuedMessages.add(msg);
  }

  void dumpQueuedMessagesToMessage() {
    _queuedMessages.forEach((m) {
      if (_existMap[m.messageId] == null) {
        _messages.insert(0, m);
        _existMap[m.messageId] = 1;
      }
    });
    _queuedMessages.clear();
  }

  void changeMessageId(String prevId, String nextId) {
    _existMap.remove(prevId);
    _existMap[nextId] = 1;
    _messages.forEach((m) {
      if (m.messageId == prevId) {
        m.messageId = nextId;
      }
    });
  }

  void appendSingleMessage(Message msg) {
    if (_existMap[msg.messageId] != null) {
      var existMsg = _messages.where((m) => m.messageId == msg.messageId);
      print("EXIST MSG WITH MESSAGEID: ${msg.messageId}");
      print("LENGTH = ${existMsg.length}");

      if (existMsg.length > 0) {
        var msg = existMsg.toList()[0];
        if (msg.isSending == true) {
          msg.changeToSent();
          return;
        }
      }
    }
    _messages.insert(0, msg);
    _existMap[msg.messageId] = 1;
  }
}
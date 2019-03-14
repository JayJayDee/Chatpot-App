import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/models/app_state.dart';

enum _RowType {
  NOTIFICATION, MY_MSG, OTHER_MSG
}

@immutable
class MessageRow extends StatelessWidget {

  final Message message;
  final AppState state;

  MessageRow({
    @required this.message,
    @required this.state
  });

  Widget build(BuildContext context) {
    String myToken = state.member.token;
    _RowType type = judgeRowType(message, myToken);

    Widget widget;
    if (type == _RowType.MY_MSG) widget = _MyMessageRow(message: message);
    else if (type == _RowType.OTHER_MSG) widget = _OtherMessageRow(message: message);
    else if (type ==_RowType.NOTIFICATION) widget = _NotificationRow(message: message);
    return Center(
      child: widget
    );
  }

  _RowType judgeRowType(Message msg, String myToken) {
    if (msg.messageType == MessageType.NOTIFICATION) return _RowType.NOTIFICATION;
    else if (msg.from.token == myToken) return _RowType.MY_MSG;
    return _RowType.OTHER_MSG;
  }
}

class _NotificationRow extends StatelessWidget {
  final Message message;

  _NotificationRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Center();
  }
}

class _MyMessageRow extends StatelessWidget {
  final Message message;

  _MyMessageRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Center();
  }
}

class _OtherMessageRow extends StatelessWidget {
  final Message message;

  _OtherMessageRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Text(message.getTextContent());
  }
}
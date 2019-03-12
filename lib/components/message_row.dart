import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/message.dart';

@immutable
class MessageRow extends StatelessWidget {

  final Message message;

  MessageRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Center(
      child: Text(message.getTextContent())
    );
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
    return Center();
  }
}
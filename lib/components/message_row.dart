import 'dart:async';
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
    return Center();
  }
}
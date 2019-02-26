import 'package:flutter/cupertino.dart';

abstract class EventReceivable {
  Future<void> onSelected(BuildContext context);
}
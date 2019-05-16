import 'dart:async';
import 'package:flutter/cupertino.dart';

abstract class EventReceivable {
  Future<void> onSelected(BuildContext context);
}

abstract class TabActor {
  Future<void> changeTab(int tabIdx);
}
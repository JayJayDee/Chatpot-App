import 'dart:async';

abstract class MessagesAccessor {
  Future<int> getNumMessagesAfter(String roomToken);
}
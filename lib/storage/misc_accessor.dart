import 'dart:async';

abstract class MiscAccessor {
  Future<bool> isFirstTime();
  Future<void> setNotFirstTime();
}
import 'dart:async';
import 'package:chatpot_app/styles.dart';

abstract class MiscAccessor {
  Future<bool> isFirstTime();
  Future<void> setNotFirstTime();
  Future<void> clearFirstTime();

  Future<StyleType> getSavedStyleType();
  Future<void> saveStyleType(StyleType type);
}
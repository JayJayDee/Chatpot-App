import 'dart:async';
import 'package:chatpot_app/storage/misc_accessor.dart';

class PrefMiscAccessor extends MiscAccessor {
  Future<bool> isFirstTime() async {
    return false;
  }
  Future<void> setNotFirstTime() async {
    
  }
}
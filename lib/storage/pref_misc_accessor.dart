import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/storage/misc_accessor.dart';

SharedPreferences _prefInst;
Future<SharedPreferences> _getPrefs() async {
  if (_prefInst == null) {
    _prefInst = await SharedPreferences.getInstance();
  }
  return _prefInst;
}

StyleType _toStyleType(String type) {
  if (type == 'LIGHT') return StyleType.LIGHT;
  else if (type == 'DARK') return StyleType.DARK;
  return null;
}

String _toString(StyleType type) {
  if (type == StyleType.LIGHT) return 'LIGHT';
  else if (type == StyleType.DARK) return 'DARK';
  return '';
}

const STYLE_TYPE_KEY = 'STYLE_TYPE';

class PrefMiscAccessor extends MiscAccessor {
  Future<bool> isFirstTime() async {
    return false;
  }
  Future<void> setNotFirstTime() async {
    
  }

  Future<StyleType> getSavedStyleType() async {
    var prefs = await _getPrefs();
    String savedStyle = prefs.getString(STYLE_TYPE_KEY);
    if (savedStyle == null) return StyleType.LIGHT;
    return _toStyleType(savedStyle);
  }

  Future<void> saveStyleType(StyleType type) async {
    var prefs = await _getPrefs();
    String expr = _toString(type);
    await prefs.setString(STYLE_TYPE_KEY, expr);
  }
}
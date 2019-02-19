import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatpot_app/storage/auth_accessor.dart';

SharedPreferences _prefInst;
Future<SharedPreferences> _getPrefs() async {
  if (_prefInst == null) {
    _prefInst = await SharedPreferences.getInstance();
  }
  return _prefInst;
}

class PrefAuthAccessor implements AuthAccessor {
  Future<String> getToken() async {
    var prefs = await _getPrefs();
    return prefs.getString('TOKEN');
  }

  Future<void> setToken(String token) async {
    var prefs = await _getPrefs();
    await prefs.setString('TOKEN', token);
  }

  Future<String> getSessionKey() async {
    var prefs = await _getPrefs();
    return prefs.getString('SESSION');
  }

  Future<void> setSessionKey(String sessionKey) async {
    var prefs = await _getPrefs();
    await prefs.setString('SESSION', sessionKey);
  }

  Future<String> getPassword() async {
    var prefs = await _getPrefs();
    return prefs.getString('PASSWORD');
  }

  Future<void> setPassword(String password) async {
    var prefs = await _getPrefs();
    await prefs.setString('PASSWORD', password);
  }
}
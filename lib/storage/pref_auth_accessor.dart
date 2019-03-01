import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatpot_app/storage/auth_accessor.dart';

SharedPreferences _prefInst;
Future<SharedPreferences> _getPrefs() async {
  if (_prefInst == null) {
    _prefInst = await SharedPreferences.getInstance();
  }
  return _prefInst;
}

const TOKEN_KEY = 'CP_TOKEN';
const SESSION_KEY = 'CP_SESSION';
const PASSWORD_KEY = 'CP_PASSWORD';

class PrefAuthAccessor implements AuthAccessor {
  Future<String> getToken() async {
    var prefs = await _getPrefs();
    return prefs.getString(TOKEN_KEY);
  }

  Future<void> setToken(String token) async {
    var prefs = await _getPrefs();
    await prefs.setString(TOKEN_KEY, token);
  }

  Future<String> getSessionKey() async {
    var prefs = await _getPrefs();
    return prefs.getString(SESSION_KEY);
  }

  Future<void> setSessionKey(String sessionKey) async {
    var prefs = await _getPrefs();
    await prefs.setString(SESSION_KEY, sessionKey);
  }

  Future<String> getPassword() async {
    var prefs = await _getPrefs();
    return prefs.getString(PASSWORD_KEY);
  }

  Future<void> setPassword(String password) async {
    var prefs = await _getPrefs();
    await prefs.setString(PASSWORD_KEY, password);
  }
}
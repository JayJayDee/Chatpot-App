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
    return '';
  }

  Future<void> setToken(String token) async {

  }

  Future<String> getSessionKey() async {
    return '';
  }

  Future<void> setSessionKey(String sessionKey) async {

  }

  Future<String> getPassword() async {
    return '';
  }

  Future<void> setPassword(String password) async {

  }
}
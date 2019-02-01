import 'package:shared_preferences/shared_preferences.dart';
import '../entities/member.dart';

Future<Auth> fetchAuthFromLocal() async {
  SharedPreferences preps = await SharedPreferences.getInstance();
  String token = preps.getString('token');
  String secret = preps.getString('secret');
  String sessionKey = preps.getString('session');
  
  if (token == null || secret == null) return null;
  Auth auth = Auth(authToken: token, secret: secret);
  if (sessionKey != null) auth.sessionKey = sessionKey;
  return auth;
}

Future<void> storeAuthToLocal(Auth auth) async {
  SharedPreferences preps = await SharedPreferences.getInstance();
  await preps.setString('token', auth.authToken);
  await preps.setString('secret', auth.secret);
  await preps.setString('session', auth.sessionKey);
}
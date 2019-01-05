import 'package:shared_preferences/shared_preferences.dart';
import '../entities/member.dart';

Future<Auth> fetchAuthFromLocal() async {
  SharedPreferences preps = await SharedPreferences.getInstance();
  String token = preps.getString('token');
  String secret = preps.getString('secret');
  
  if (token == null || secret == null) {
    return null;
  }
  Auth auth = Auth(authToken: token, secret: secret);
  return auth;
}

Future<void> storeAuthToLocal(String authToken, String secret) async {
  SharedPreferences preps = await SharedPreferences.getInstance();
  await preps.setString('token', authToken);
  await preps.setString('secret', secret);
}
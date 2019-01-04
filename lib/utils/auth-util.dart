import 'package:shared_preferences/shared_preferences.dart';
import '../entities/member.dart';

Future<Auth> fetchAuthFromLocal() async {
  Auth auth = new Auth();
  
  SharedPreferences preps = await SharedPreferences.getInstance();
  String token = preps.getString('token');
  String secret = preps.getString('secret');
  
  if (token == null || secret == null) {
    return null;
  }

  auth.authToken = token;
  auth.secret = secret;
  return auth;
}

Future<void> storeAuthToLocal(Auth auth) async {
  SharedPreferences preps = await SharedPreferences.getInstance();
  await preps.setString('token', auth.authToken);
  await preps.setString('secret', auth.secret);
}
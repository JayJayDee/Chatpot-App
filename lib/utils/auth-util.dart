import 'package:shared_preferences/shared_preferences.dart';
import '../entities/member.dart';

Future<Auth> fetchAuthFromLocal() async {
  Auth auth = new Auth();
  
  SharedPreferences preps = await SharedPreferences.getInstance();
  String token = preps.getString('token');
  auth.authToken = token;
  return auth;
}

Future<void> storeAuthToLocal(Auth auth) async {
  SharedPreferences preps = await SharedPreferences.getInstance();
  preps.setString('token', auth.authToken);
}
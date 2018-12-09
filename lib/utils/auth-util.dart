import 'package:shared_preferences/shared_preferences.dart';
import '../models/member-model.dart';

Future<Auth> fetchAuthFromLocal() async {
  Auth auth = new Auth();
  
  SharedPreferences preps = await SharedPreferences.getInstance();
  String token = preps.getString('token');
  auth.authToken = token;
  return auth;
}
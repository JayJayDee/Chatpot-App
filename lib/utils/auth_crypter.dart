import 'package:meta/meta.dart';

abstract class AuthCrypter {
  
  String createRefreshToken({
    @required String token,
    @required String password,
    @required String oldSessionKey
  });

}
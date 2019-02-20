import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:chatpot_app/utils/auth_crypter.dart';

class DefaultAuthCrypter extends AuthCrypter {

  String createRefreshToken({
    @required String token,
    @required String password,
    @required String oldSessionKey
  }) {
    String rawRefToken = "$token$oldSessionKey$password";
    var bytes = utf8.encode(rawRefToken);
    return '${sha256.convert(bytes)}';
  }
}
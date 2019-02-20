import 'package:meta/meta.dart';
import 'package:chatpot_app/utils/auth_crypter.dart';

class DefaultAuthCrypter extends AuthCrypter {

  String createRefreshToken({
    @required String token,
    @required String password,
    @required String oldSessionKey
  }) {
    return '';
  }

}
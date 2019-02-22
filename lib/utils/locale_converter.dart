import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/member.dart';

class LocaleConverter {
  String _language;

  void selectLanguage(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
  }

  String getNick(Nick nick) {
    if (_language == 'ko') return nick.ko;
    else if (_language == 'ja') return nick.ja;
    return _convertNickEnOnly(nick.en);
  }

  String _convertNickEnOnly(String enNick) =>
    enNick.split(' ')
      .map((String token) => '${token[0].toUpperCase()}${token.substring(1)}')
      .join(' ');
}
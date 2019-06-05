import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/locales/home_scene_locales.dart';
import 'package:chatpot_app/locales/message_locales.dart';
import 'package:chatpot_app/locales/room_locales.dart';
import 'package:chatpot_app/locales/chats_scene_locales.dart';
import 'package:chatpot_app/locales/setting_scene_locales.dart';
import 'package:chatpot_app/locales/message_scene_locales.dart';
import 'package:chatpot_app/locales/more_chat_scene_locales.dart';
import 'package:chatpot_app/locales/new_chat_scene_locales.dart';
import 'package:chatpot_app/locales/login_scene_locales.dart';
import 'package:chatpot_app/locales/photo_detail_scene_locales.dart';
import 'package:chatpot_app/locales/signup_scene_locales.dart';
import 'package:chatpot_app/locales/email_upgrade_scene_locales.dart';
import 'package:chatpot_app/locales/error_message_locales.dart';
import 'package:chatpot_app/locales/simple_signup_scene_locales.dart';

class RootLocaleConverter {
  String _language;
  HomeSceneLocales _home;
  ChatsSceneLocales _chats;
  SettingSceneLocales _settings;
  MessageLocales _message;
  RoomLocales _room;
  MessageSceneLocales _msgscene;
  MoreChatSceneLocales _morechat;
  NewChatSceneLocales _newchat;
  LoginSceneLocales _login;
  PhotoDetailSceneLocales _photoDetail;
  SignupSceneLocales _signupScene;
  EmailUpgradeSceneLocales _emailUpgradeScene;
  ErrorMessageLocales _errorLocales;
  SimpleSignupSceneLocales _simpleSignup;

  HomeSceneLocales get home => _home;
  MessageLocales get message => _message;
  RoomLocales get room => _room;
  ChatsSceneLocales get chats => _chats;
  SettingSceneLocales get setting => _settings;
  MessageSceneLocales get msgscene => _msgscene;
  MoreChatSceneLocales get morechat => _morechat;
  NewChatSceneLocales get newchat => _newchat;
  LoginSceneLocales get login => _login;
  PhotoDetailSceneLocales get photoDetail =>  _photoDetail;
  SignupSceneLocales get signupScene => _signupScene;
  EmailUpgradeSceneLocales get emailUpgradeScene => _emailUpgradeScene;
  ErrorMessageLocales get error => _errorLocales;
  SimpleSignupSceneLocales get simpleSignup => _simpleSignup;

  void selectLanguage(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    _login = LoginSceneLocales(root: this, language: _language);
    _language = locale.languageCode;
    _home = HomeSceneLocales(root: this, language: _language);
    _message = MessageLocales(root: this, language: _language);
    _room = RoomLocales(root: this, language: _language);
    _chats = ChatsSceneLocales(root: this, language: _language);
    _settings = SettingSceneLocales(root: this, language: _language);
    _msgscene = MessageSceneLocales(root: this, language: _language);
    _morechat = MoreChatSceneLocales(root: this, language: _language);
    _newchat = NewChatSceneLocales(root: this, language: _language);
    _photoDetail = PhotoDetailSceneLocales(root: this, language: _language);
    _signupScene = SignupSceneLocales(root: this, language: _language);
    _emailUpgradeScene = EmailUpgradeSceneLocales(root: this, language: _language);
    _errorLocales = ErrorMessageLocales(root: this, language: _language);
    _simpleSignup = SimpleSignupSceneLocales(root: this, language: _language);
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

  String toDateTime(DateTime dt) {
    DateFormat formatter;
    if (_language == 'ko') formatter = DateFormat('yyyy년 M월 d일 hh시 mm분 ss초');
    else if (_language == 'ja') formatter = DateFormat('yyyy年 M月 d日 hh時 mm分 ss秒');
    else formatter = DateFormat('MMMM d, yyyy hh:mm:ss');
    return formatter.format(dt);
  }

  AssetImage getFlagImage(String regionCode) {
    String lowered = regionCode.toLowerCase();
    String path = "assets/$lowered.png";
    return AssetImage(path);
  }

  String get errorAlertDefaultTitle {
    if (_language == 'ko') return '에러 발생';
    else if (_language == 'ja') return 'エラーが発生しました';
    return 'An error has occured';
  }
  
  String get okButtonLabel {
    if (_language == 'ko') return '확인';
    else if (_language == 'ja') return 'OK';
    return 'Ok';
  }
}
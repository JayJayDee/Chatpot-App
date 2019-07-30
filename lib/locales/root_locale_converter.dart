import 'package:chatpot_app/locales/profile_edit_scene_locales.dart';
import 'package:chatpot_app/locales/report_scene_locales.dart';
import 'package:chatpot_app/locales/room_detail_scene_locales.dart';
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
import 'package:chatpot_app/locales/password_change_scene_locales.dart';
import 'package:chatpot_app/locales/member_detail_sheet_locales.dart';
import 'package:chatpot_app/locales/about_scene_locales.dart';
import 'package:chatpot_app/locales/eula_scene_locales.dart';
import 'package:chatpot_app/locales/report_history_scene_locales.dart';
import 'package:chatpot_app/locales/block_history_scene_locales.dart';
import 'package:chatpot_app/locales/image_send_confirm_scene_locales.dart';
import 'package:chatpot_app/locales/setting_theme_scene_locales.dart';
import 'package:chatpot_app/locales/new_roulette_scene_locales.dart';

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
  PasswordChangeSceneLocales _passwordChange;
  MemberDetailSheetLocales _memberDetailSheet;
  AboutSceneLocales _aboutScene;
  EulaSceneLocales _eulaScene;
  ReportSceneLocales _reportScene;
  ReportHistorySceneLocales _reportHistoryScene;
  BlockHistorySceneLocales _blockHistoryScene;
  ImageSendConfirmSceneLocales _imageConfirmScene;
  RoomDetailSceneLocales _roomDetailScene;
  SettingThemeSceneLocales _settingThemeScene;
  ProfileEditSceneLocales _profileEditScene;
  NewRouletteSceneLocales _newRouletteSceneLocales;

  HomeSceneLocales get home {
    if (_home == null) {
      _home = HomeSceneLocales(root: this, language: _language);
    }
    return _home;
  }

  MessageLocales get message {
    if (_message == null) {
      _message = MessageLocales(root: this, language: _language);
    }
    return _message;
  }

  RoomLocales get room {
    if (_room == null) {
      _room = RoomLocales(root: this, language: _language);
    }
    return _room;
  }

  ChatsSceneLocales get chats {
    if (_chats == null) {
      _chats = ChatsSceneLocales(root: this, language: _language);
    }
    return _chats;
  }

  SettingSceneLocales get setting {
    if (_settings == null) {
      _settings = SettingSceneLocales(root: this, language: _language);
    }
    return _settings;
  } 

  MessageSceneLocales get msgscene {
    if (_msgscene == null) {
      _msgscene = MessageSceneLocales(root: this, language: _language);
    }
    return _msgscene;
  }

  MoreChatSceneLocales get morechat {
    if (_morechat == null) {
      _morechat = MoreChatSceneLocales(root: this, language: _language);
    }
    return _morechat;
  }

  NewChatSceneLocales get newchat {
    if (_newchat == null) {
      _newchat = NewChatSceneLocales(root: this, language: _language);
    }
    return _newchat;
  }

  NewRouletteSceneLocales get roulettechat {
    if (_newRouletteSceneLocales == null) {
      _newRouletteSceneLocales = NewRouletteSceneLocales(root: this, language: _language);
    }
    return _newRouletteSceneLocales;
  }

  LoginSceneLocales get login {
    if (_login == null) {
      _login = LoginSceneLocales(root: this, language: _language);
    }
    return _login;
  }

  PhotoDetailSceneLocales get photoDetail {
    if (_photoDetail == null) {
      _photoDetail = PhotoDetailSceneLocales(root: this, language: _language);
    }
    return _photoDetail;
  } 

  SignupSceneLocales get signupScene {
    if (_signupScene == null) {
      _signupScene = SignupSceneLocales(root: this, language: _language);
    }
    return _signupScene;
  }

  EmailUpgradeSceneLocales get emailUpgradeScene {
    if (_emailUpgradeScene == null) {
      _emailUpgradeScene = EmailUpgradeSceneLocales(root: this, language: _language);
    }
    return _emailUpgradeScene;
  }

  ErrorMessageLocales get error {
    if (_errorLocales == null) {
      _errorLocales = ErrorMessageLocales(root: this, language: _language);
    }
    return _errorLocales;
  }

  SimpleSignupSceneLocales get simpleSignup {
    if (_simpleSignup == null) {
      _simpleSignup = SimpleSignupSceneLocales(root: this, language: _language);
    }
    return _simpleSignup;
  }

  PasswordChangeSceneLocales get passwordChange {
    if (_passwordChange == null) {
      _passwordChange = PasswordChangeSceneLocales(root: this, language: _language);
    }
    return _passwordChange;
  }

  MemberDetailSheetLocales get memberDetailSheet {
    if (_memberDetailSheet == null) {
      _memberDetailSheet = MemberDetailSheetLocales(root: this, language: _language);
    }
    return _memberDetailSheet;
  }

  AboutSceneLocales get aboutScene {
    if (_aboutScene == null) {
      _aboutScene = AboutSceneLocales(root: this, language: _language);
    }
    return _aboutScene;
  }

  EulaSceneLocales get eulaScene {
    if (_eulaScene == null) {
      _eulaScene = EulaSceneLocales(root: this, language: _language);
    }
    return _eulaScene;
  }

  ReportSceneLocales get reportScene {
    if (_reportScene == null) {
      _reportScene = ReportSceneLocales(root: this, language: _language);
    }
    return _reportScene;
  } 

  ReportHistorySceneLocales get reportHistoryScene {
    if (_reportHistoryScene == null) {
      _reportHistoryScene = ReportHistorySceneLocales(root: this, language: _language);
    }
    return _reportHistoryScene;
  }

  BlockHistorySceneLocales get blockHistoryScene {
    if (_blockHistoryScene == null) {
      _blockHistoryScene = BlockHistorySceneLocales(root: this, language: _language);
    }
    return _blockHistoryScene;
  }

  ImageSendConfirmSceneLocales get imageConfirmScene {
    if (_imageConfirmScene == null) {
      _imageConfirmScene = ImageSendConfirmSceneLocales(root: this, language: _language);
    }
    return _imageConfirmScene;
  }

  RoomDetailSceneLocales get roomDetailScene {
    if (_roomDetailScene == null) {
      _roomDetailScene = RoomDetailSceneLocales(root: this, language: _language);
    }
    return _roomDetailScene;
  }

  SettingThemeSceneLocales get settingThemeScene {
    if (_settingThemeScene == null) {
      _settingThemeScene = SettingThemeSceneLocales(root: this, language: _language);
    }
    return _settingThemeScene;
  } 

  ProfileEditSceneLocales get profileEditScene {
    if (_profileEditScene == null) {
      _profileEditScene = ProfileEditSceneLocales(root: this, language: _language);
    }
    return _profileEditScene;
  }

  String get langauge => _language;

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

  String get successTitle {
    if (_language == 'ko') return '성공';
    else if (_language == 'ja') return '成功';
    return 'Success';
  }
}
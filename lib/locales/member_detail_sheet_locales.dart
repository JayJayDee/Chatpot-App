import 'package:chatpot_app/locales/root_locale_converter.dart';

class MemberDetailSheetLocales {
  String language;
  RootLocaleConverter root;

  MemberDetailSheetLocales ({
    this.language,
    this.root
  });

  String get menuOneononeChat {
    if (language == 'ko') return '1:1 채팅 시작';
    else if (language == 'ja') return '1：1チャットを開始';
    return 'Start 1:1 chat';
  }

  String get menuBlockUser {
    if (language == 'ko') return '차단하기';
    else if (language == 'ja') return 'ユーザをブロックする';
    return 'Block user';
  }

  String get menuReportUser {
    if (language == 'ko') return '신고하기';
    else if (language == 'ja') return 'ユーザーを報告する';
    return 'Report user';
  }
}
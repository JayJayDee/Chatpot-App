import 'package:chatpot_app/locales/root_locale_converter.dart';

class MessageSceneLocales {
  String language;
  RootLocaleConverter root;

  MessageSceneLocales({
    this.language,
    this.root
  });

  String get leave {
    if (language == 'ko') return '나가기';
    else if (language == 'ja') return '去る';
    return 'Leave';
  }

  String get cancel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return '取消';
    return 'Cancel';
  }

  String get leaveDialogTitle {
    if (language == 'ko') return '채팅 나가기';
    else if (language == 'ja') return 'チャットから離れる';
    return 'Leaving from chat';
  }

  String get leaveDialogText {
    if (language == 'ko') return '정말로 이 채팅방에서 나가시겠습니까?';
    else if (language == 'ja') return 'このチャットを離れますか？';
    return 'Are you sure you want to leave this chat?';
  }

  String get messageEmpty {
    if (language == 'ko') return '메시지를 작성하셔야 합니다.';
    else if (language == 'ja') return 'あなたはメッセージを記入する必要があります。';
    return 'You need to fill out the message.';
  }

  String get blockTitle {
    if (language == 'ko') return '사용자 차단';
    else if (language == 'ja') return 'ブロックしているユーザー';
    return 'Blocking user';
  }

  String get blockConfirm {
    if (language == 'ko') {
      return '''선택한 사용자를 차단합니다.
사용자를 차단하면 대화 목록에서 해당 사용자의 모든 대화가 노출되지 않습니다.
차단한 사용자 목록은 설정 메뉴 > 내 차단 내역 메뉴에서 확인 할 수 있습니다.
정말 차단하시겠습니까?''';
    }
    else if (language == 'ja') {
      return '''選択したユーザーをブロックする
ユーザーをブロックしても、スレッド内でそのユーザーのすべての会話が公開されるわけではありません。
ブロックされたユーザーのリストは、[設定]メニュー> [自分のブロック履歴]メニューにあります。
本当にブロックしますか？''';
    }
    return '''Blocking selected user.
Blocking a user will not expose all conversations for that user in the thread.
A list of blocked users can be found in the Settings menu > My Block History menu.
Do you really want to block it?
    ''';
  }

  String get doBlockButtonLabel {
    if (language == 'ko') return '차단';
    else if (language == 'ja') return 'ブロック';
    return 'Block';
  }

  String get cancelButtonLabel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return 'キャンセル';
    return 'Cancel';
  }

  String get alreadyBlockedMember {
    if (language == 'ko') return '''이미 차단한 사용자입니다.
이전에 차단한 사용자 목록은 설정 메뉴 > 내 차단 내역 메뉴에서 확인 할 수 있습니다.''';
    else if (language == 'ja') return '''既にブロックされているユーザー
以前にブロックされたユーザーのリストは、[設定]メニュー> [自分のブロック履歴]メニューにあります。''';
    return '''Already blocked user.
A list of previously blocked users can be found in the Settings menu > My Block History menu.''';   
  }

  String get blockSuccess {
    if (language == 'ko') return '''지정한 사용자 차단에 성공하였습니다.
차단 목록은 설정 메뉴 > 내 차단 내역 메뉴에서 확인 할 수 있습니다.''';
    else if (language == 'ja') return '''指定されたユーザーは正常にブロックされました。
ブラックリストは、[設定]メニュー> [ブロック履歴]メニューにあります。''';
    return '''The specified user was successfully blocked.
The blacklist can be found in the Settings menu > My Block History menu.''';
  }

  String get copied {
    if (language == 'ko') return '''선택한 메시지가
클립보드에 복사되었습니다.''';
    else if (language == 'ja') return '''選択されたメッセージは
クリップボードにコピーしました。''';
    return '''The selected message has been
copied to the clipboard.''';
  }

  String get selectedTextTitle {
    if (language == 'ko') return '선택한 메시지';
    else if (language == 'ja') return '選択したメッセージ';
    return 'Selected message';
  }

  String get selectedTextMenuCopy {
    if (language == 'ko') return '클립보드에 복사';
    else if (language == 'ja') return 'クリップボードにコピー';
    return 'Copy to Clipboard';
  }

  String get wrongUrl {
    if (language == 'ko') return '잘못된 URL입니다.';
    else if (language == 'ja') return '無効なURL。';
    return 'Invalid URL.';
  }
}
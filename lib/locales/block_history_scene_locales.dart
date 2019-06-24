import 'package:chatpot_app/locales/root_locale_converter.dart';
import 'package:chatpot_app/entities/block.dart';

class BlockHistorySceneLocales {
  String language;
  RootLocaleConverter root;

  BlockHistorySceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '내 차단 내역';
    else if (language == 'ja') return 'ブロッキング履歴';
    return 'My blocking history';
  }

  String get emptyBlocks {
    if (language == 'ko') return '차단 내역이 없습니다.';
    else if (language == 'ja') return 'ブロック履歴はありません。';
    return 'No blocking history.';
  }

  String blockDate(DateTime dt) {
    if (language == 'ko') return "차단일시: ${dt.year}/${dt.month}/${dt.day} ${dt.hour}:${dt.minute}:${dt.second}";
    else if (language == 'ja') return 'ブロック履歴はありません。';
    return "Blocked at ${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute}:${dt.second}";
  }

  String menuText(BlockEntry entry) {
    if (language == 'ko') return """${this.root.getNick(entry.nick)}

선택한 사용자에 대해 차단을 해제하거나 추가로 신고를 진행할 수 있습니다.""";

    else if (language == 'ja') return """${this.root.getNick(entry.nick)}

選択したユーザーのブロックを解除することも、さらに報告することもできます。""";

    return """${this.root.getNick(entry.nick)}

You can unblock the selected user, or you can further report them.""";
  }

  String get reportButtonLabel {
    if (language == 'ko') return '신고하기';
    else if (language == 'ja') return '申告';
    return 'Report';
  }

  String get unblockButtonLabel {
    if (language == 'ko') return '차단 해제';
    else if (language == 'ja') return 'ブロックを解除';
    return 'Unblock';
  }

  String get unblockDialogTitle {
    if (language == 'ko') return '차단 해제';
    else if (language == 'ja') return 'ブロックを解除';
    return 'Unblock';
  }

  String get unblockDialogContent {
    if (language == 'ko') return '정말로 선택한 사용자에 대한 차단을 해제하시겠습니까?';
    else if (language == 'ja') return 'ユーザーのブロックを解除してもよろしいですか？';
    return 'Are you sure you want to unblock the user?';
  }

  String get unblockDialogYes {
    if (language == 'ko') return '차단 해제';
    else if (language == 'ja') return 'ブロック解除';
    return 'Unblock';
  }

  String get unblockDialogCancel {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return 'キャンセル';
    return 'Cancel';
  }

  String get unblockCompleted {
    if (language == 'ko') return '차단 해제가 완료되었습니다.';
    else if (language == 'ja') return 'ブロック解除が完了しました。';
    return 'Unblocking is complete.';
  }
}
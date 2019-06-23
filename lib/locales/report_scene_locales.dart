import 'package:chatpot_app/locales/root_locale_converter.dart';

class ReportSceneLocales {
  String language;
  RootLocaleConverter root;

  ReportSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '다른 사용자 신고';
    else if (language == 'ja') return 'ユーザーを報告';
    return 'Report an user';
  }

  String get prevButtonLabel {
    if (language == 'ko') return '이전';
    else if (language == 'ja') return '前';
    return 'Prev';
  }

  String get description1 {
    if (language == 'ko') return '선택한 사용자가 신고 대상이 맞는지 확인해주세요.';
    else if (language == 'ja') return '選択したユーザーがレポートの対象かどうかを確認してください。';
    return 'Please check if the selected user is the target of the report.';
  }

  String get description2 {
    if (language == 'ko') {
      return '''제출 버튼을 누르면 현재 채팅방의 채팅 내용이 서버로 전송됩니다. 

전송된 채팅 내용은 관리자가 검토하는데 사용되며, 검토가 완료되면 채팅 내용을 즉시 파기합니다.

검토는 최대 24시간이 소요되며, 신고한 내용에 대한 처리 결과는 설정 메뉴 > 내 신고 현황 메뉴에서 확인하실 수 있습니다.''';
    } else if (language == 'ja') {
      return '''送信ボタンをクリックすると、現在のチャットルームのチャットルームがサーバーに送信されます。

送信されたチャットコンテンツは管理者によってレビューに使用され、レビューが完了するとチャットコンテンツはすぐに破棄されます。

レビューには最大24時間かかり、レポートの処理結果は[設定]メニュー> [マイレポートステータス]メニューに表示されます。''';
    }
    return '''If you click the submit button, the chat room of the current chat room is sent to the server.

Sent chat content is used by the administrator for review, and when review is complete, the chat content is immediately discarded.

The review can take up to 24 hours, and the results of processing the report can be found in the Settings menu> My Report Status menu.''';
  }

  String get reportButtonLabel {
    if (language == 'ko') return '제출';
    else if (language == 'ja') return '提出';
    return 'Submit';
  }

  String get hateLabel {
    if (language == 'ko') return '혐오 발언';
    else if (language == 'ja') return '憎悪発言';
    return 'Hate speech';
  }

  String get sexualLabel {
    if (language == 'ko') return '성희롱';
    else if (language == 'ja') return 'セクハラ';
    return 'Sexual harassment';
  }

  String get etcLabel {
    if (language == 'ko') return '기타';
    else if (language == 'ja') return 'その他';
    return 'Other';
  }

  String get chooseReportType {
    if (language == 'ko') return '신고 유형을 선택하세요';
    else if (language == 'ja') return 'レポートの種類を選択してください。';
    return 'Please select a report type.';
  }

  String get commentFieldPlacholder {
    if (language == 'ko') return '자세한 내용 (선택 사항)';
    else if (language == 'ja') return '詳細（オプション）';
    return 'Details (Optional)';
  }

  String get reportTypeSelectionRequired {
    if (language == 'ko') return '신고 유형을 선택하셔야 합니다.';
    else if (language == 'ja') return 'レポートの種類を選択する必要があります。';
    return 'You must choice a report type.';
  }
}
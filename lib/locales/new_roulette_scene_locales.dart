import 'package:chatpot_app/locales/root_locale_converter.dart';

class NewRouletteSceneLocales {
  String language;
  RootLocaleConverter root;

  NewRouletteSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '새 랜덤 채팅';
    else if (language == 'ja') return '新しいランダムチャット';
    return 'New chat roulette';
  }

  String get previous {
    if (language == 'ko') return '이전';
    else if (language == 'ja') return '前';
    return 'Prev';
  }

  String get description {
    if (language == 'ko') return '새로운 랜덤채팅을 신청하거나, 기존 신청을 취소합니다.';
    else if (language == 'ja') return '新しいチャットルーレットを申請するか、既存の申請をキャンセルします。';
    return 'Applying for a new chat roulette or cancel your existing application.';
  }

  String get indicatorMatched {
    if (language == 'ko') return '매칭 완료';
    else if (language == 'ja') return '一致しました';
    return 'Matched';
  }

  String get indicatorWaiting {
    if (language == 'ko') return '매칭 대기중..';
    else if (language == 'ja') return '待機中';
    return 'Waiting for peer..';
  }

  String get newChatDescription {
    if (language == 'ko') return '새로운 랜덤 채팅 신청을 위해 아래의 매칭 타입을 선택해 주세요. 신청 후 매칭까지는 시간이 걸릴 수 있습니다. 매칭이 완료되면 푸시 메시지로 알려 드립니다.';
    else if (language == 'ja') return '下記のマッチングタイプを選択してください。 応募後のマッチングに時間がかかる場合があります。 試合が完了したら、プッシュメッセージでお知らせします。';
    return 'Please select the matching type below. It may take some time for matching after application. We will notify you with a push message when the match is complete.';
  }

  String get btnLabelForeigner {
    if (language == 'ko') return "외국인과\n매칭";
    else if (language == 'ja') return '外国人とは';
    return "With\nForeigner";
  }

  String get btnLabelAnybody {
    if (language == 'ko') return "아무나\n매칭";
    else if (language == 'ja') return '誰とでも';
    return "With\nAnybody";
  }

  String get confirmTitle {
    if (language == 'ko') return '랜덤채팅 신청';
    else if (language == 'ja') return 'ランダムチャットに申し込む';
    return 'Applying for a chat roulette';    
  }

  String get foreignerConfirm {
    if (language == 'ko') return '외국인과의 랜덤채팅을 신청합니다. 정말 신청하시겠습니까?';
    else if (language == 'ja') return '外国人とチャットルーレットを申請する。 本当に応募しますか？';
    return 'Applying for a chat roulette with a foreigner. Do you really want to apply?';
  }

  String get anybodyConfirm {
    if (language == 'ko') return '모든 사람과의 랜덤채팅을 신청합니다. 정말 신청하시겠습니까?';
    else if (language == 'ja') return '誰とでもチャットルーレットを申請する。 本当に応募しますか？';
    return 'Applying for a chat roulette with a anybody. Do you really want to apply?';
  }

  String get myRouletteChat {
    if (language == 'ko') return '내 랜덤채팅들';
    else if (language == 'ja') return '私のランダムチャット';
    return 'My chat roulettes';
  }

  String get newRouletteChat {
    if (language == 'ko') return '새 랜덤채팅';
    else if (language == 'ja') return '新しいランダムチャット';
    return 'New chat roulette';
  }

  String get enterBtnLabel {
    if (language == 'ko') return '입장';
    else if (language == 'ja') return '入場';
    return 'Enter';
  }
}
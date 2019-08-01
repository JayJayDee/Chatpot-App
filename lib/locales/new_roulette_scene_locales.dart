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
    return 'Waiting..';
  }
}
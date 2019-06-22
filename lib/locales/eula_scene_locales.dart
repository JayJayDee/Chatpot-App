import 'package:chatpot_app/locales/root_locale_converter.dart';

class EulaSceneLocales {
  String language;
  RootLocaleConverter root;

  EulaSceneLocales ({
    this.language,
    this.root
  });

  String get title {
    if (this.language == 'ko') return '최종 사용자 사용권 계약';
    else if (this.language == 'ja') return 'ソフトウェア使用許諾契約';
    return 'End User License Agreement';
  }

  String get prevButtonLabel {
    if (this.language == 'ko') return '이전';
    else if (this.language == 'ja') return '前';
    return 'Prev';
  }

  String get agreeButtonLabel {
    if (this.language == 'ko') return '동의합니다';
    else if (this.language == 'ja') return '同意します。';
    return 'Agree';
  }

  String get eulaFetchError {
    if (this.language == 'ko') return 'EULA 내용을 가져오는 데 실패했습니다. 나중에 다시 시도해 주세요.';
    else if (this.language == 'ja') return 'EULAの内容を取得できませんでした。 後でもう一度やり直してください。';
    return 'Failed to get contents of EULA. Please try again later.';
  }
}
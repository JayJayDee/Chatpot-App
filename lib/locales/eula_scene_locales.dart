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
}
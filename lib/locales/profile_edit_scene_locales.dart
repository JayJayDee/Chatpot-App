import 'package:chatpot_app/locales/root_locale_converter.dart';

class ProfileEditSceneLocales {
  String language;
  RootLocaleConverter root;

  ProfileEditSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '내 프로필 수정';
    else if (language == 'ja') return 'ラウンジ';
    return 'Edit my profile';
  }
}
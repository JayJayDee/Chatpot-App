import 'package:chatpot_app/locales/root_locale_converter.dart';

class PhotoDetailSceneLocales {
  String language;
  RootLocaleConverter root;

  PhotoDetailSceneLocales({
    this.language,
    this.root
  });

  String get previousTitle {
    if (language == 'ko') return '뒤로';
    else if (language == 'ja') return '前へ';
    return 'Back';
  }

  String get title {
    if (language == 'ko') return '사진';
    else if (language == 'ja') return '写真';
    return 'Photo';
  }
}
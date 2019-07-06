import 'package:chatpot_app/locales/root_locale_converter.dart';

class ImageSendConfirmSceneLocales {
  String language;
  RootLocaleConverter root;

  ImageSendConfirmSceneLocales({
    this.language,
    this.root
  });

  String get title {
    if (language == 'ko') return '이미지 선택';
    else if (language == 'ja') return '画像を選択';
    return 'Select an image';
  }

  String get btnSelectImage {
    if (language == 'ko') return '선택';
    else if (language == 'ja') return '選択する';
    return 'Select';
  }
}
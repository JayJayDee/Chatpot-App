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

  String get savedMemesTitle {
    if (language == 'ko') return '저장된 짤들';
    else if (language == 'ja') return '画像を選択';
    return 'Saved memes';
  }

  String get btnSendImage {
    if (language == 'ko') return '전송';
    else if (language == 'ja') return '送信';
    return 'Send';
  }

  String get btnSelectImageFromGallery {
    if (language == 'ko') return '갤러리에서 선택';
    else if (language == 'ja') return 'ギャラリーから選択';
    return 'Select from gallery';
  }

  String get imageSelectionRequired {
    if (language == 'ko') return '전송할 사진을 선택하셔야 합니다.';
    else if (language == 'ja') return '送信したい写真を選択する必要があります。';
    return 'You need to select the photos you want to send.';
  }
}
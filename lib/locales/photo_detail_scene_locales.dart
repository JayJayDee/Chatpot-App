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

  String get btnDownload {
    if (language == 'ko') return '다운로드';
    else if (language == 'ja') return 'ダウンロード';
    return 'Download';
  }

  String failedToDownload(String cause) {
    if (language == 'ko') return "이미지 다운로드에 실패했습니다: $cause";
    else if (language == 'ja') return "画像のダウンロードに失敗しました： $cause";
    return "Failed to download an image: $cause";
  }

  String get downloadSuccess {
    if (language == 'ko') return '이미지 다운로드에 성공했습니다.';
    else if (language == 'ja') return '画像をダウンロードしました。';
    return 'An image has downloaded successfully.';
  }
}
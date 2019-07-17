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

  String get description {
    if (language == 'ko') return '''내 별명과 아바타 사진을 랜덤하게 바꿀 수 있습니다.
주의하세요! 바꿀 수 있는 횟수는 제한되어 있습니다.''';
    else if (language == 'ja') return '''あなたは私のニックネームとアバターの写真をランダムなニックネームとランダムなアバターの写真に変更することができます。
ご注意ください！ 変更できる回数は限られています。''';
    return '''You can change your nickname and avatar pictures to random nicknames and random avatar pictures.
Please note! The number of times you can change is limited.''';
  }

  String get avatar {
    if (language == 'ko') return '아바타';
    else if (language == 'ja') return 'アバター';
    return 'Avatar';
  }

  String get nick {
    if (language == 'ko') return '닉네임';
    else if (language == 'ja') return 'ニックネーム';
    return 'Nickname';
  }

  String remainCount(int remains) {
    if (language == 'ko') return "남은 주사위 $remains개";
    else if (language == 'ja') return "残り$remains個のサイコロ";
    return "$remains remaining dice(s)";
  }
}
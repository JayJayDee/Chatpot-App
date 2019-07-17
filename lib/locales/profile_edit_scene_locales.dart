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

  String remainCount(var remains) {
    if (language == 'ko') return "남은 주사위 $remains개";
    else if (language == 'ja') return "残り$remains個のサイコロ";
    return "$remains remaining dice(s)";
  }

  String get gachaConfirmTitle {
    if (language == 'ko') return '확인';
    else if (language == 'ja') return '確認';
    return 'Confirmation';
  }

  String get gachaNickDesc {
    if (language == 'ko') return '''확인 버튼을 클릭하면 즉시 랜덤한 닉네임으로 변경되며, 복구 할 수 없습니다.
정말 닉네임을 랜덤하게 변경하시겠습니까?''';
    else if (language == 'ja') return '''[OK]ボタンをクリックすると、すぐにランダムなニックネームに変更され、元に戻すことはできません。
あなたは本当にランダムにあなたのニックネームを変えたいですか？''';
    return '''If you click the OK button, it will be immediately changed to a random nickname and can not be recovered.
Do you really want to change your nickname randomly?''';
  }

  String get gachaAvatarDesc {
    if (language == 'ko') return '''확인 버튼을 클릭하면 즉시 랜덤한 아바타로 변경되며, 복구할 수 없습니다.
정말 아바타를 랜덤하게 변경하시겠습니까?''';
    else if (language == 'ja') return '''OKボタンをクリックすると即座にランダムなアバターに変わりますが、これは元に戻すことはできません。
あなたは本当にあなたのアバターをランダムに変えたいですか？''';
    return '''Clicking the OK button will instantly change to a random avatar, which can not be restored.
Do you really want to change your avatar randomly?''';
  }

  String get okTitle {
    if (language == 'ko') return '확인';
    else if (language == 'ja') return 'OK';
    return 'OK';
  }

  String get cancelTitle {
    if (language == 'ko') return '취소';
    else if (language == 'ja') return 'キャンセル';
    return 'Cancel';
  }

  String get resultTitle {
    if (language == 'ko') return '변경 완료!';
    else if (language == 'ja') return '変更完了！';
    return 'Change made!';
  }
}
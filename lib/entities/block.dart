import 'package:chatpot_app/entities/member.dart';

class BlockEntry {
  String _memberToken;
  String _note;
  Nick _nick;
  Avatar _avatar;

  BlockEntry() {
    _memberToken = null;
    _note = '';
    _nick = Nick();
    _avatar = Avatar();
  }

  String get memberToken => _memberToken;
  String get note => _note;
  Nick get nick => _nick;
  Avatar get avatar => _avatar;

  factory BlockEntry.fromMap(Map<String, dynamic> map) {
    BlockEntry entry = BlockEntry();
    entry._memberToken = map['member_token'];
    entry._note = map['note'];
    entry._nick.en = map['nick_en'];
    entry._nick.ko = map['nick_ko'];
    entry._nick.ja = map['nick_ja'];
    entry._avatar.thumb = map['avatar_thumbnail'];
    return entry;
  }
}
import 'package:chatpot_app/entities/member.dart';

class BlockEntry {
  String _memberToken;
  String _roomToken;
  String _note;
  String _region;
  Nick _nick;
  Avatar _avatar;
  DateTime _blockDate;

  BlockEntry() {
    _memberToken = null;
    _note = '';
    _nick = Nick();
    _avatar = Avatar();
  }

  String get memberToken => _memberToken;
  String get roomToken => _roomToken;
  String get note => _note;
  Nick get nick => _nick;
  Avatar get avatar => _avatar;
  String get region => _region;
  DateTime get blockDate => _blockDate;

  factory BlockEntry.fromMap(Map<String, dynamic> map) {
    BlockEntry entry = BlockEntry();
    entry._memberToken = map['member_token'];
    entry._roomToken = map['room_token'];
    entry._note = map['note'];
    entry._nick.en = map['nick_en'];
    entry._nick.ko = map['nick_ko'];
    entry._nick.ja = map['nick_ja'];
    entry._avatar.thumb = map['avatar_thumbnail'];
    entry._region = map['region'];
    entry._blockDate = DateTime.fromMillisecondsSinceEpoch(map['timestamp'] * 1000);
    return entry;
  }
}
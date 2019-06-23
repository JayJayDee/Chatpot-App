import 'package:meta/meta.dart';

class BlockEntry {
  String _memberToken;
  String _note;

  BlockEntry() {
    _memberToken = null;
    _note = '';
  }

  String get memberToken => _memberToken;
  String get note => _note;

  factory BlockEntry.instantiate({
    @required String memberToken,
    String note
  }) {
    BlockEntry entry = BlockEntry();
    entry._memberToken = memberToken;
    entry._note = note;
    return entry;
  }

  factory BlockEntry.fromMap(Map<String, dynamic> map) {
    BlockEntry entry = BlockEntry();
    entry._memberToken = map['member_token'];
    entry._note = map['note'];
    return entry;
  }
}
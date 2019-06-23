import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/block.dart';

class AlreadyBlockedMemberError {}

abstract class BlockAccessor {
  Future<void> block({
    @required String memberToken,
    String note
  });
  Future<void> unblock(String memberToken);
  Future<List<BlockEntry>> fetchAllBlockEntries();
}
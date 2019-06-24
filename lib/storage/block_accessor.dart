import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/block.dart';
import 'package:chatpot_app/entities/member.dart';

class AlreadyBlockedMemberError {}

abstract class BlockAccessor {
  Future<void> block({
    @required String memberToken,
    @required String roomToken,
    @required String region,
    @required Nick nick,
    @required Avatar avatar,
    String note
  });

  Future<void> unblock(String memberToken);

  Future<List<BlockEntry>> fetchAllBlockEntries();
}
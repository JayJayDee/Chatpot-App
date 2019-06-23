import 'dart:async';
import 'package:chatpot_app/entities/block.dart';

abstract class BlockAccessor {
  Future<void> block(BlockEntry entry);
  Future<void> unblock(String memberToken);
  Future<List<BlockEntry>> fetchAllBlockEntries();
}
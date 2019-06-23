import 'dart:async';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:chatpot_app/storage/block_accessor.dart';
import 'package:chatpot_app/entities/block.dart';
import 'package:sqflite/sqflite.dart';

class AlreadyBlockedMemberError {}

class SqliteBlockAccessor implements BlockAccessor {

  final String dbName;
  final int dbVersion = 1;
  Database _db;

  SqliteBlockAccessor({
    @required this.dbName
  }) {
    _getDb();
  }

  Future<Database> _getDb() async {
    if (_db != null) return _db;

    String dbPath = await getDatabasesPath();
    String fullPath = join(dbPath, dbName);

    Database database = await openDatabase(fullPath,
      version: dbVersion,
      onCreate: (Database db, int version) async {
        String createSql = """
          CREATE TABLE member_blocks_$dbVersion (
            no INTEGER PRIMARY KEY AUTOINCREMENT,
            member_token VARCHAR(80) NOT NULL,
            note VARCHAR(200) NOT NULL,
            timestamp INTEGER NOT NULL
          );
        """;
        await db.execute(createSql);
        String indexSql = """
          CREATE UNIQUE INDEX uniq_blocks_$dbVersion ON
            member_blocks_$dbVersion (member_token)
        """;
        await db.execute(indexSql);
      }
    );
    _db = database;
    return database;
  }

  Future<void> block(BlockEntry entry) async {
    int now = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    String insertQuery = """
      INSERT INTO member_blocks_$dbVersion
        (member_token, note, timestamp)
      VALUES
        (?, ?, ?)
    """;
    List<dynamic> values = [
      entry.memberToken,
      entry.note,
      now
    ];
    var db = await _getDb();
    await db.rawInsert(insertQuery, values);
  }

  Future<void> unblock(String memberToken) async {
    // TODO: to be implemented
  }

  Future<List<BlockEntry>> fetchAllBlockEntries() async {
    List<BlockEntry> list = List();
    return list;
  }
}
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:chatpot_app/storage/block_accessor.dart';
import 'package:chatpot_app/entities/block.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:sqflite/sqflite.dart';

class SqliteBlockAccessor implements BlockAccessor {

  final String dbName;
  final int dbVersion = 2;
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
            nick_en VARCHAR(30) NOT NULL,
            nick_ja VARCHAR(30) NOT NULL,
            nick_ko VARCHAR(30) NOT NULL,
            avatar_thumbnail VARCHAR(200) NOT NULL,
            note VARCHAR(200) NULL,
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

  Future<void> block({
    @required String memberToken,
    @required Nick nick,
    @required Avatar avatar,
    String note
  }) async {
    int now = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    String insertQuery = """
      INSERT INTO member_blocks_$dbVersion
        (member_token, note, timestamp,
          nick_en, nick_ja, nick_ko,
          avatar_thumbnail)
      VALUES
        (?, ?, ?, ?, ?, ?, ?)
    """;
    List<dynamic> values = [
      memberToken,
      note,
      now,
      nick.en,
      nick.ja,
      nick.ko,
      avatar.thumb
    ];
    var db = await _getDb();
    try {
      await db.rawInsert(insertQuery, values);
    } catch (err) {
      if (err is DatabaseException) {
        if (err.isUniqueConstraintError()) {
          throw new AlreadyBlockedMemberError();
        }
        throw err;
      } else {
        throw err;
      }
    }
  }

  Future<void> unblock(String memberToken) async {
    // TODO: to be implemented
  }

  Future<List<BlockEntry>> fetchAllBlockEntries() async {
    String selectQuery = """
      SELECT
        *
      FROM
        member_blocks_$dbVersion
    """;
    var db = await _getDb();
    List<Map<String, dynamic>> rows = await db.rawQuery(selectQuery);
    List<BlockEntry> list = rows.map((elem) =>
      BlockEntry.fromMap(elem)
    ).toList();
    return list;
  }
}
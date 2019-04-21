import 'dart:async';
import 'package:path/path.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/storage/translation_cache_accessor.dart';
import 'package:sqflite/sqflite.dart';

class SqliteTranslationCacheAccessor extends TranslationCacheAccessor {

  final String dbName;
  final int dbVersion = 1;
  Database _db;

  SqliteTranslationCacheAccessor({
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
          CREATE TABLE translation_cache_$dbVersion (
            no INTEGER PRIMARY KEY AUTOINCREMENT,
            room_token VARCHAR(80) NOT NULL,
            message_id VARCHAR(80) NOT NULL,
            translated TEXT NOT NULL
          )
        """;
        await db.execute(createSql);
        String indexSql = """
          CREATE INDEX idx_translation_$dbVersion ON
            translation_cache_$dbVersion (room_token, message_id)
        """;
        await db.execute(indexSql);
      }
    );
    _db = database;
    return database;
  }

  Future<void> cacheRoomTitleTranslations({
    @required List<Translated> translated
  }) async {
    List<dynamic> values = [];
    String valuesClause = translated.map((t) {
      values.addAll([t.key, 'ROOM_TITLE', t.translated]);
      return "(?,?,?)";
    }).toList().join(',');
    String insertQuery = """
      INSERT INTO translation_cache_$dbVersion
        (room_token, message_id, translated)
      VALUES
        $valuesClause
    """;
    var db = await _getDb();
    await db.rawInsert(insertQuery, values);
  }

  Future<void> cacheTranslations({
    @required String roomToken,
    @required List<Translated> translated
  }) async {
    List<dynamic> values = [];
    String valuesClause = translated.map((t) {
      values.addAll([roomToken, t.key, t.translated]);
      return "(?, ?, ?)";
    }).toList().join(',');
    String insertQuery = """
      INSERT INTO translation_cache_$dbVersion
        (room_token, message_id, translated)
      VALUES
        $valuesClause
    """;
    var db = await _getDb();
    await db.rawInsert(insertQuery, values);
  }

  Future<List<Translated>> getCachedRoomTitleTranslations({
    @required List<String> keys
  }) async {
    if (keys.length == 0) return [];
    String inClause = keys.map((k) => "'$k'").toList().join(',');
    String selectQuery = """
      SELECT 
        room_token,
        translated
      FROM 
        translation_cache_$dbVersion
      WHERE
        room_token IN ($inClause) AND
        message_id='ROOM_TITLE'
    """;

    var db = await _getDb();
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
    List<Translated> translates = result.map((elem) =>
      Translated(
        key: elem['room_token'],
        translated: elem['translated']
      )
    ).toList();
    return translates;
  }

  Future<List<Translated>> getCachedTranslations({
    @required String roomToken,
    @required List<String> keys
  }) async {
    if (keys.length == 0) return [];
    String inClause = keys.map((k) => "'$k'").toList().join(',');
    String selectQuery = """
      SELECT 
        message_id,
        translated
      FROM 
        translation_cache_$dbVersion
      WHERE
        room_token='$roomToken' AND
        message_id IN ($inClause)
    """;

    var db = await _getDb();
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
    List<Translated> translates = result.map((elem) =>
      Translated(
        key: elem['message_id'],
        translated: elem['translated']
      )
    ).toList();
    return translates;
  }
}
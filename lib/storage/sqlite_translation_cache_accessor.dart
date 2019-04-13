import 'dart:async';
import 'package:path/path.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/storage/translation_cache_accessor.dart';
import 'package:sqflite/sqflite.dart';

class SqliteTranslationCacheAccessor extends TranslationCacheAccessor {

  final String dbName;
  Database _db;

  SqliteTranslationCacheAccessor({
    @required this.dbName
  }) {
    _initAsync();
  }

  void _initAsync() async {
    String dbPath = await getDatabasesPath();
    String fullPath = join(dbPath, dbName);

    Database database = await openDatabase(fullPath,
      onCreate: (Database db, int version) async {
        String createSql = """
          CREATE TABLE translation_cache (
            no INTEGER PRIMARY KEY AUTOINCREMENT,
            room_token VARCHAR(80) NOT NULL,
            message_id VARCHAR(80) NOT NULL,
            translated TEXT NOT NULL
          )
        """;
        await db.execute(createSql);
        String indexSql = """
          CREATE INDEX idx_translation ON
            translation_cache (room_token, message_id)
        """;
        await db.execute(indexSql);
      }
    );
    _db = database;
    print('DB INITED!');
  }

  Future<void> cacheTranslations({
    @required String roomToken,
    @required List<Translated> translated
  }) async {
    List<String> values = translated.map((t) =>
      "('$roomToken','${t.key}','${t.translated}')").toList();
    String valuesClause = values.join(',');
    String insertQuery = """
      INSERT INTO translation_cache
        (room_token, message_id, translated)
      VALUES
        $valuesClause
    """;
    if (_db == null) {
      print("DB NULL!");
    } else {
      await _db.execute(insertQuery);
    }
  }

  Future<List<Translated>> getCachedTranslations({
    @required String roomToken,
    @required List<String> keys
  }) async {
    return null;
  }
}
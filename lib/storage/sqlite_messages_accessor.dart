import 'dart:async';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:chatpot_app/storage/messages_accessor.dart';

class SqliteMessagesAccessor implements MessagesAccessor {
  String _dbName;
  Database _db;

  SqliteMessagesAccessor({
    @required String dbName
  }) {
    _dbName = dbName;
  }

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String fullPath = path.join(dbPath, _dbName);
    Database db = await openDatabase(fullPath,
      version: 1,
      onCreate: (Database db, int version) {
        // TODO: initial table creation query.
      }
    );
    return db;
  }

  Future<int> getNumMessagesAfter(String roomToken) async {
    if (_db == null) _db = await _initDb();
    return 1;
  }
}
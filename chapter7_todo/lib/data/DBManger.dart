import 'package:sqflite/sqflite.dart';
import 'package:todo/model/Project.dart';
import 'package:todo/model/Todo.dart';

class DBManager {
  static Database _db;

  static Future<Database> getDB() async {
    if (_db == null) {
      _db = await openDatabase("todo.db",
        onCreate: (db, version) {
          db.execute(TABLE_CREATE_SQL_TODO);
          db.execute(TABLE_CREATE_SQL_PROJECT);
        },
        version: 1
      );
    }

    return _db;
  }
}
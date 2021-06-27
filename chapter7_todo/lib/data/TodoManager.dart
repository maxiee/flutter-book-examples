import 'package:sqflite/sqflite.dart';
import 'package:todo/data/DBManger.dart';
import 'package:todo/model/Todo.dart';

class TodoManager {
  static Future<void> createTodo(Todo todo) async {
    final db = await DBManager.getDB();

    await db.insert(
      TABLE_NAME_TODO,
      todo.toMap(),
    );
  }

  static Future<void> updateTodo(Todo todo) async {
    final db = await DBManager.getDB();

    await db.update(
      TABLE_NAME_TODO,
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id]
    );
  }

  static Future<List<Todo>> getAllTodo() async {
    final db = await DBManager.getDB();
    final todoList = await db.query(TABLE_NAME_TODO);

    return List.generate(
        todoList.length,
        (index) => Todo.fromMap(todoList[index]));
  }
}
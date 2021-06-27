import 'package:sqflite/sqflite.dart';
import 'package:todo/data/DBManger.dart';
import 'package:todo/model/Project.dart';

class ProjectManager {
  static Future<void> createProject(Project project) async {
    final db = await DBManager.getDB();

    await db.insert(
      TABLE_NAME_PROJECT,
      project.toMap(),
    );
  }

  static Future<void> updateProject(Project project) async {
    final db = await DBManager.getDB();

    await db.update(
      TABLE_NAME_PROJECT,
      project.toMap(),
      where: "id = ?",
      whereArgs: [project.id]
    );
  }

  static Future<List<Project>> getAllProject() async {
    final db = await DBManager.getDB();
    final projectList = await db.query(TABLE_NAME_PROJECT);

    return List.generate(
      projectList.length,
      (index) => Project.fromMap(projectList[index]));
  }
}
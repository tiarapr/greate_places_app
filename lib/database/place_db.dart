import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'great_places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, description TEXT, location TEXT, date TEXT, image TEXT)',
        );
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBUtil.database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBUtil.database();
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBUtil.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> update(
      String table, String id, Map<String, dynamic> data) async {
    final db = await DBUtil.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
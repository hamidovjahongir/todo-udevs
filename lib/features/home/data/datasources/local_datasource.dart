import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/core/extensions/todo_model_x.dart';
import 'package:todo/features/home/data/models/todo_model.dart';

class LocalDatasource {
  static Database? _db;
  static const String _tableName = 'todo';

  // DB init
  static Future<void> init() async {
    if (_db != null) return;

    final path = join(await getDatabasesPath(), 'todo.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            location TEXT,
            color TEXT,
            time TEXT,
            onSaveTime TEXT,
            onEndTime TEXT
          )
        ''');
      },
    );
  }

  // Insert
  static Future<int> insert(TodoModel todo) async {
    await init();
    return await _db!.insert(
      _tableName,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all
  static Future<List<TodoModel>> getAll() async {
    await init();
    final data = await _db!.query(_tableName);
    return data.map((e) => TodoModel.fromJson(e)).toList();
  }

  // Get one
  static Future<TodoModel?> getOne(int id) async {
    await init();
    final data = await _db!.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      return TodoModel.fromJson(data.first);
    }
    return null;
  }

  // Delete
  static Future<int> delete(int id) async {
    await init();
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  // Update
  static Future<TodoModel?> update(int id, TodoModel todo) async {
    await init();
    final count = await _db!.update(
      _tableName,
      todo.toUpdateJson(),
      where: 'id = ?',
      whereArgs: [id],
    );

    if (count > 0) {
      final data = await _db!.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (data.isNotEmpty) {
        return TodoModel.fromJson(data.first);
      }
    }
    return null;
  }
}

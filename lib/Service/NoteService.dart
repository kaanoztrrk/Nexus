import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/Note.dart';
import '../Models/Todo.dart';

class NoteDatabaseProvider {
  NoteDatabaseProvider._();

  static final NoteDatabaseProvider db = NoteDatabaseProvider._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "note_app.db"),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          creationDate TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Eğer veritabanı sürümü 2'den küçükse, güncelleme işlemlerini burada gerçekleştirin
          await db.execute('''
          ALTER TABLE notes
          ADD COLUMN creationDate TEXT
        ''');
        }
      },
      version: 2, // Veritabanı sürüm numarasını güncelleyin
    );
  }

  addnewNote(NoteModel note) async {
    final db = await database;
    db.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db.query("notes");
    if (res.length == 0) {
      return null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id = ?", [id]);
    return count;
  }
}

class TodoDatabaseProvider {
  TodoDatabaseProvider._();

  static final TodoDatabaseProvider db = TodoDatabaseProvider._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "todo_app.db"),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE todo (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          creationDate TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          ALTER TABLE todo
          ADD COLUMN creationDate TEXT
        ''');
        }
      },
      version: 2,
    );
  }

  addNewTodo(ToDoModel todo) async {
    final db = await database;
    db.insert("todo", todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getTodos() async {
    final db = await database;
    var res = await db.query("todo");
    if (res.length == 0) {
      return null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    int count = await db.rawDelete("DELETE FROM todo WHERE id = ?", [id]);
    return count;
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $memeTableName(
            id TEXT PRIMARY KEY,
            name TEXT,
            url TEXT,
            width INTEGER,
            height INTEGER,
            box_count INTEGER,
            captions INTEGER
          )
        ''');
      },
    );
  }
}

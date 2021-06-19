import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class DatabaseProvider {
  final databaseName = 'mediary_database.db';
  final databaseVersion = 2;

  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = await _initDatabase();
    return database;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: _createTable,
      onUpgrade: _updateTable,
      version: 7,
    );
  }

  void _createTable(Database db, int version) {
    db.execute('''
          CREATE TABLE medicines(
            id INTEGER PRIMARY KEY,
            name TEXT,
            quantity INTEGER,
            unit TEXT,
            takenAt TEXT,
            createdAt TEXT,
            updatedAt TEXT
          )
        ''');
  }

  void _updateTable(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS medicines;");
      _createTable(db, newVersion);
    }
  }
}

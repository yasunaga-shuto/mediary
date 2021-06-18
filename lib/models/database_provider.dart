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
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute('''
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
      },
      version: 2,
    );
  }
}

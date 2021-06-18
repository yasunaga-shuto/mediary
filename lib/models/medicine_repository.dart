import 'package:mediary/models/database_provider.dart';
import 'package:mediary/models/medicine.dart';
import 'package:sqflite/sqflite.dart';

class MedicineRepository {
  static String table = "medicines";
  static DatabaseProvider instance = DatabaseProvider.instance;

  static Future<Medicine> create(
      String name, int quantity, String unit, String takenAt) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'takenAt': takenAt,
      'createdAt': now.toString(),
      'updatedAt': now.toString(),
    };
    final db = await instance.database;
    final id = await db.insert(table, row);
    return Medicine(
      id: id,
      name: row['title'],
      quantity: row['quantity'],
      unit: row['unit'],
      takenAt: row['takenAt'],
      createdAt: now,
      updatedAt: now,
    );
  }

  static Future<List<Medicine>> getAll() async {
    final Database db = await instance.database;

    final rows =
        await db.rawQuery('SELECT * FROM $table ORDER BY updatedAt DESC');
    return rows.map((json) => Medicine.fromMap(json)).toList();
  }
}

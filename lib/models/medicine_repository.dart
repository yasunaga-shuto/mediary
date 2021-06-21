import "package:mediary/models/database_provider.dart";
import "package:mediary/models/medicine.dart";
import "package:mediary/helpers/time_of_day_helper.dart";
import "package:sqflite/sqflite.dart";

class MedicineRepository {
  static String table = "medicines";
  static DatabaseProvider instance = DatabaseProvider.instance;

  static Future<Medicine> create(
      String name, int quantity, String unit, String takenAt) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      "name": name,
      "quantity": quantity,
      "unit": unit,
      "takenAt": takenAt,
      "createdAt": now.toString(),
      "updatedAt": now.toString(),
    };
    final db = await instance.database;
    final id = await db.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Medicine(
      id: id,
      name: row["name"],
      quantity: row["quantity"],
      unit: row["unit"],
      takenAt: TimeOfDayHelper.parse(row["takenAt"]),
      createdAt: now,
      updatedAt: now,
    );
  }

  static Future<List<Medicine>> getAll() async {
    final db = await instance.database;

    final rows = await db.rawQuery("SELECT * FROM $table");
    return rows.map((json) => Medicine.fromMap(json)).toList();
  }

  static Future<bool> updateMedicine(
    int? id,
    String? name,
    int? quantity,
    String? takenAt,
  ) async {
    final now = DateTime.now();
    final db = await instance.database;
    try {
      db.update(
        "medicines",
        {
          "name": name,
          "quantity": quantity,
          "takenAt": takenAt,
          "updatedAt": now.toString(),
        },
        where: "id=?",
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

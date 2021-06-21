import "package:flutter/material.dart";
import "package:mediary/models/medicine.dart";
import "package:mediary/models/medicine_repository.dart";

class MedicineModel extends ChangeNotifier {
  List<Medicine> list = [];

  Future<List<Medicine>> getMedicines() async {
    list = await MedicineRepository.getAll();
    notifyListeners();
    return list;
  }

  Future<Medicine> createMedicine(
    name,
    quantity,
    takenAt,
  ) async {
    var medicine =
        await MedicineRepository.create(name, quantity, "錠", takenAt);
    notifyListeners();
    return medicine;
  }

  Future<bool> updateMedicine(
    id,
    name,
    quantity,
    takenAt,
  ) async {
    var isUpdated = await MedicineRepository.updateMedicine(
      id,
      name,
      quantity,
      takenAt,
    );
    notifyListeners();
    return isUpdated;
  }
}

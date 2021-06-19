import 'package:flutter/material.dart';
import 'package:mediary/models/medicine.dart';
import 'package:mediary/models/medicine_repository.dart';

class MedicineModel extends ChangeNotifier {
  List<Medicine> list = [];

  Future<List<Medicine>> getMedicines() async {
    list = await MedicineRepository.getAll();
    notifyListeners();
    return list;
  }
}

import 'package:flutter/material.dart';
import 'package:mediary/models/medicine.dart';
import 'package:mediary/models/medicine_repository.dart';

class MedicineModel extends ChangeNotifier {
  List<Medicine> list = [];

  void getMedicines() async {
    list = await MedicineRepository.getAll();
    notifyListeners();
  }
}

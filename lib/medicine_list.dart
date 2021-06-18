import 'package:flutter/material.dart';
import 'package:mediary/models/medicine_model.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    var model = MedicineModel();
    model.getMedicines();
    var medicines = model.list;
    if (medicines.isEmpty) {
      return _buildEmptyState();
    } else {
      return ListView();
    }
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_state.png', width: 230),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'お薬の登録がありません',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const Text('右下のボタンからお薬の登録ができます。'),
      ],
    );
  }
}

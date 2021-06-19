import 'package:flutter/material.dart';
import 'package:mediary/models/medicine_model.dart';
import 'package:mediary/models/medicine.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MedicineModel().getMedicines(),
      builder: _buildList,
    );
  }

  Widget _buildList(
    BuildContext context,
    AsyncSnapshot<List<Medicine>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        return _buildMedicineList();
      } else {
        return _buildEmptyState();
      }
    } else {
      return const CircularProgressIndicator();
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

  Widget _buildMedicineList() {
    return ListView();
  }
}

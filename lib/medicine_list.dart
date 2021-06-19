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
        return _buildMedicineList(snapshot);
      } else {
        return _buildEmptyState();
      }
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _buildMedicineList(AsyncSnapshot<List<Medicine>> medicines) {
    var data = medicines.data;
    return ListView.separated(
      itemCount: data!.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == data.length) {
          return const Divider(height: 1);
        }

        return ListTile(
          title: Text(data[index].name),
          subtitle: Text(
            "${data[index].takenAt.format(context)} - ${data[index].quantity}錠",
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
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

import "package:flutter/material.dart";
import "package:mediary/medicine_form.dart";
import "package:mediary/models/medicine_model.dart";
import "package:mediary/models/medicine.dart";

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  MedicineListState createState() => MedicineListState();
}

class MedicineListState extends State<MedicineList> {
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
      if (snapshot.data!.isEmpty) {
        return _buildEmptyState();
      } else {
        return _buildMedicineList(snapshot);
      }
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _buildMedicineList(AsyncSnapshot<List<Medicine>> medicines) {
    final _medicines = medicines.data;
    return ListView.separated(
      itemCount: _medicines!.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == _medicines.length) {
          return const Divider(height: 1);
        }

        final _medicine = _medicines[index];
        return ListTile(
          title: Text(_medicine.name),
          subtitle: Text(
            "${_medicine.takenAt.format(context)} - ${_medicine.quantity}錠",
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MedicineForm(
                type: "edit",
                id: _medicine.id,
                name: _medicine.name,
                quantity: _medicine.quantity,
                takenAt: _medicine.takenAt,
              );
            })).then((value) {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value),
                duration: const Duration(seconds: 3),
              ));
            });
          },
          trailing: const Icon(Icons.chevron_right),
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
        Image.asset("assets/images/empty_state.png", width: 230),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            "お薬の登録がありません",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const Text("右下のボタンからお薬の登録ができます。"),
      ],
    );
  }
}

import "package:flutter/material.dart";
import "package:mediary/models/medicine_model.dart";
import "package:mediary/models/medicine.dart";
import 'package:mediary/helpers/date_helper.dart';
import 'package:mediary/helpers/time_of_day_helper.dart';

class MedicinesCheckList extends StatefulWidget {
  const MedicinesCheckList({Key? key}) : super(key: key);

  @override
  _MedicinesCheckListState createState() => _MedicinesCheckListState();
}

class _MedicinesCheckListState extends State<MedicinesCheckList> {
  Future<List<Medicine>>? _medicines;
  List<bool?>? _takenList;

  @override
  void initState() {
    _medicines = MedicineModel().getMedicines();
    _setTakenList();
    super.initState();
  }

  void _setTakenList() async {
    var medicines = await MedicineModel().getMedicines();
    _takenList = medicines.map((medicine) => false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _medicines,
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
        return _buildChecklist(snapshot.data);
      }
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TODO: 画像変更
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
        const Text("薬一覧からお薬を登録してみましょう。"),
      ],
    );
  }

  Widget _buildChecklist(medicines) {
    return ListView.separated(
      itemCount: medicines == null ? 1 : medicines.length + 2,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
      itemBuilder: (BuildContext context, int index) {
        if (index == medicines.length + 1) {
          return const Divider(height: 1);
        }
        if (index == 0) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.chevron_left),
                Text(DateHelper.getFormattedToday()),
                const Icon(Icons.chevron_right),
              ],
            ),
          );
        }

        final medicine = medicines[index - 1];
        return CheckboxListTile(
          title: Text(
            medicine.name,
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            "${medicine.quantity}錠 - ${TimeOfDayHelper.fromTimeOfDay(medicine.takenAt)}",
          ),
          value: _takenList![index - 1],
          onChanged: (checked) {
            setState(() {
              _takenList![index - 1] = checked;
            });
          },
          secondary: Image.asset("assets/images/medicine.png", width: 37),
          activeColor: Colors.green,
        );
      },
    );
  }
}

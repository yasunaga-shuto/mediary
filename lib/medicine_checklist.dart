import "package:flutter/material.dart";
import "package:mediary/models/medicine_model.dart";
import "package:mediary/models/medicine.dart";
import 'package:mediary/helpers/date_helper.dart';

class MedicinesCheckList extends StatefulWidget {
  const MedicinesCheckList({Key? key}) : super(key: key);

  @override
  _MedicinesCheckListState createState() => _MedicinesCheckListState();
}

class _MedicinesCheckListState extends State<MedicinesCheckList> {
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

        return CheckboxListTile(
          title: const Text("ジェイゾロフト", style: TextStyle(color: Colors.black)),
          subtitle: const Text("1錠 - 19:30"),
          value: false,
          onChanged: _takeMedicine(),
          secondary: Image.asset("assets/images/jazoloft.jpeg", width: 45),
        );
      },
    );
  }

  _takeMedicine() {}
}

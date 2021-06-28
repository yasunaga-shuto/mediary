import "package:flutter/material.dart";
import "package:mediary/models/medicine_model.dart";
import "package:mediary/models/medicine.dart";

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
        return _buildChecklist();
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

  Widget _buildChecklist() {
    return ListView();
  }

  _takeMedicine() {}
}

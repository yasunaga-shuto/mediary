import 'package:flutter/material.dart';

class MedicinesCheckList extends StatefulWidget {
  const MedicinesCheckList({Key? key}) : super(key: key);

  @override
  _MedicinesCheckListState createState() => _MedicinesCheckListState();
}

class _MedicinesCheckListState extends State<MedicinesCheckList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.chevron_left),
              Text('6月17日（木）'),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
        const Divider(height: 1),
        CheckboxListTile(
          title: const Text('ジェイゾロフト', style: TextStyle(color: Colors.black)),
          subtitle: const Text('1錠 - 19:30'),
          onChanged: _takeMedicine(),
          value: false,
          activeColor: Colors.green,
          secondary: Image.asset('assets/images/medicine.png', width: 35),
        ),
        const Divider(height: 1),
        CheckboxListTile(
          title: const Text('リフレックス', style: TextStyle(color: Colors.black)),
          subtitle: const Text('1錠 - 23:30'),
          onChanged: _takeMedicine(),
          value: false,
          activeColor: Colors.green,
          secondary: Image.asset('assets/images/medicine.png', width: 35),
        ),
        const Divider(height: 1),
      ],
    );
  }

  _takeMedicine() {}
}

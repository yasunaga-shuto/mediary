import 'package:flutter/material.dart';

// medicine_checklist.dart
class MedicinesCheckList extends StatefulWidget {
  const MedicinesCheckList({Key? key}) : super(key: key);

  @override
  _MedicinesCheckListState createState() => _MedicinesCheckListState();
}

class _MedicinesCheckListState extends State<MedicinesCheckList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CheckboxListTile(
          title: const Text('ジェイゾロフト', style: TextStyle(color: Colors.black)),
          onChanged: _takeMedicine(),
          value: false,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
          secondary: const Text('19:30', style: TextStyle(color: Colors.black)),
        ),
        const Divider(),
        CheckboxListTile(
          title: const Text('リフレックス', style: TextStyle(color: Colors.black)),
          onChanged: _takeMedicine(),
          value: false,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
          secondary: const Text('23:30', style: TextStyle(color: Colors.black)),
        ),
        const Divider(),
      ],
    );
  }

  _takeMedicine() {}
}

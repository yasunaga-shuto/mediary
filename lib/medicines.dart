import 'package:flutter/material.dart';

class Medicines extends StatefulWidget {
  const Medicines({Key? key}) : super(key: key);

  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
      ),
      body: _buildList(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: const Icon(Icons.medical_services),
                  color: Colors.white,
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.event),
                  color: Colors.white,
                  onPressed: () {}),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CheckboxListTile(
          title: const Text('ジェイゾロフト', style: TextStyle(color: Colors.black)),
          onChanged: _addMedicine(),
          value: false,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
          secondary: const Text('19:30', style: TextStyle(color: Colors.black)),
        ),
        const Divider(),
        CheckboxListTile(
          title: const Text('リフレックス', style: TextStyle(color: Colors.black)),
          onChanged: _addMedicine(),
          value: false,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
          secondary: const Text('23:30', style: TextStyle(color: Colors.black)),
        ),
        const Divider(),
      ],
    );
  }

  _addMedicine() {}
}

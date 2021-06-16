// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const Mediary());

class Mediary extends StatelessWidget {
  const Mediary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mediary',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pageList = const [
    MedicinesCheckList(),
    MedicineList(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mediary'),
      ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.green[200],
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box), label: '服用チェック'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '薬一覧'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'カレンダー')
          ],
          onTap: (int index) {
            _selectedIndex = index;

            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          }),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {},
              backgroundColor: Colors.green,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

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

  void _registerMedicine() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return const MedicineRegistrationForm();
      }),
    );
  }
}

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

class MedicineRegistrationForm extends StatefulWidget {
  const MedicineRegistrationForm({Key? key}) : super(key: key);

  @override
  _MedicineRegistrationFormState createState() =>
      _MedicineRegistrationFormState();
}

class _MedicineRegistrationFormState extends State<MedicineRegistrationForm> {
  final FocusNode _quantityFocusNode = FocusNode();
  final TextEditingController _quantityTextFieldController =
      TextEditingController();

  @override
  void initState() {
    _quantityFocusNode.addListener(() {
      if (_quantityFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectTime();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('お薬の登録')),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '薬の名前 *', icon: Icon(Icons.healing)),
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                labelText: '服用量',
                                icon: Icon(Icons.takeout_dining)),
                          )),
                          const Text('錠')
                        ],
                      ),
                      TextFormField(
                        focusNode: _quantityFocusNode,
                        controller: _quantityTextFieldController,
                        decoration: const InputDecoration(
                            labelText: '服用時刻を入力 *', icon: Icon(Icons.schedule)),
                      ),
                    ],
                  )),
              SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('登録'),
                      style: ElevatedButton.styleFrom(primary: Colors.green)))
            ])));
  }

  void _selectTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (newTime != null) {
      setState(() {
        _quantityTextFieldController.text = newTime.format(context).toString();
      });
    }
  }
}

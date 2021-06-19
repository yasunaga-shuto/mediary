import 'package:flutter/material.dart';
import 'medicine_checklist.dart';
import 'medicine_list.dart';
import 'medicine_registration_form.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                    return const MedicineRegistrationForm();
                  }),
                );
              },
              backgroundColor: Colors.green,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

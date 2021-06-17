// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/medicine.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'mediary_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE medicines(id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, takenAt TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertMedicine(Medicine medicine) async {
    final db = await database;

    await db.insert('medicines', medicine.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Medicine>> medicines() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('medicines');

    return List.generate(maps.length, (i) {
      return Medicine(
        id: maps[i]['id'],
        name: maps[i]['name'],
        quantity: maps[i]['quantity'],
        takenAt: maps[i]['takenAt'],
      );
    });
  }

  runApp(const Mediary());
}

class Mediary extends StatelessWidget {
  const Mediary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mediary',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: const Home());
  }
}

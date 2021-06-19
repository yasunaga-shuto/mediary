// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'home.dart';

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
      home: const Home(),
    );
  }
}

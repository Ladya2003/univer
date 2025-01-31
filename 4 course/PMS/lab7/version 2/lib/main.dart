import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'HobbyEntityListPage.dart';

void main() async {
  runApp(HobbyApp());
}

class HobbyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hobbys',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HobbyEntityListPage(),
    );
  }
}

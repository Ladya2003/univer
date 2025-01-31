import 'package:flutter/material.dart';
import 'package:laba4/HomeScreen/presentation/CategoryBlock.dart';
import 'package:laba4/HomeScreen/presentation/homeIcon.dart';
import 'package:laba4/HomeScreen/presentation/notificationIcon.dart';
import 'package:laba4/HomeScreen/presentation/searchBlock.dart';

import 'HomeScreen/presentation//BottomSheet.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        leading: HomeIcon(),
        actions: [
          NotificationIcon(),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Center(child: SearchBlock()),
            SizedBox(height: 15.0),
            CategoryBlock(),
            SizedBox(height: 20.0),
            Expanded(child: BottomSheetBlock()),
          ],
        ),
      ),
    );
  }
}



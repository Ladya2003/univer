import 'package:flutter/material.dart';
import '/HomeScreen/presentation/CategoryBlock.dart';
import '/HomeScreen/presentation/homeIcon.dart';
import '/HomeScreen/presentation/notificationIcon.dart';
import '/HomeScreen/presentation/searchBlock.dart';

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
      backgroundColor: Color(0xFF7F8CA2),
      appBar: AppBar(
        backgroundColor: Color(0xFF7F8CA2),
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



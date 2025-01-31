import 'package:flutter/material.dart';
import '/HomeScreen/presentation/CategoryBlock.dart';
import '/HomeScreen/presentation/homeIcon.dart';
import '/HomeScreen/presentation/notificationIcon.dart';
import '/HomeScreen/presentation/searchBlock.dart';

import 'HomeScreen/presentation//BottomSheet.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        leading: const HomeIcon(),
        actions: const [
          NotificationIcon(),
        ],
      ),
      body: const Center(
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



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '/profileScreen.dart';
import '/searchBlock.dart';

import 'BottomSheet.dart';
import 'CategoryBlock.dart';
import 'firebaseFirestore.dart';
import 'homeIcon.dart';
import 'loginScreen.dart';
import 'notificationIcon.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Фоновое сообщение: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );


  addInitialProducts();


  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab4-5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}



class HomeScreen extends StatelessWidget {
  final FirestoreService firestoreService;
  final bool isAdmin;

  HomeScreen({
    Key? key,
    FirestoreService? firestoreService,
    this.isAdmin = true,
  })  : firestoreService = firestoreService ?? FirestoreService(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        leading: HomeIcon(),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen()),
              );
            },
          ),
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
            Expanded(child: BottomSheetBlock(isAdmin: isAdmin)),
          ],
        ),
      ),
    );
  }
}


Future<void> addInitialProducts() async {
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  QuerySnapshot snapshot = await products.limit(1).get();
  if (snapshot.docs.isEmpty) {

    List<Map<String, dynamic>> initialProducts = [
      {
        'name': 'Puma Model 1',
        'price': 94,
        'image': 'assets/images/puma1.png',
        'description': 'Описание продукта 1',
      },
      {
        'name': 'Puma Model 2',
        'price': 120,
        'image': 'assets/images/puma1.png',
        'description': 'Описание продукта 2',
      },
    ];


    for (var product in initialProducts) {
      await products.add(product);
    }
  }
}
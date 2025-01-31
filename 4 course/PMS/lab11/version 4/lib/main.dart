import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab11_test3/profileScreen.dart';
import 'package:lab11_test3/searchBlock.dart';

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

  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    print('Уведомления не разрешены');
  } else {
    print('Уведомления разрешены');
  }

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

class HomeScreen extends StatefulWidget {
  final FirestoreService firestoreService;
  final bool isAdmin;

  HomeScreen({
    Key? key,
    FirestoreService? firestoreService,
    this.isAdmin = true,
  })  : firestoreService = firestoreService ?? FirestoreService(),
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  Future<void> _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Получение FCM-токена
    String? token = await messaging.getToken();
    if (token != null) {
      print('FCM Token: $token');
      // Сохранение токена в Firestore для текущего пользователя
      User? user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(user.uid)
      //       .update({'fcmToken': token});
      // }
    }

    // Обработка сообщений, полученных, когда приложение открыто
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Сообщение получено: ${message.notification?.title}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message.notification?.body ?? 'Сообщение получено')),
      );
    });
  }

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
            Expanded(child: BottomSheetBlock(isAdmin: widget.isAdmin)),
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

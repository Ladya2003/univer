import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginScreen.dart';



class UserProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль пользователя'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: user != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Email: ${user!.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('UID: ${user!.uid}', style: TextStyle(fontSize: 18)),
          ],
        ),
      )
          : Center(
        child: Text('Пользователь не авторизован'),
      ),
    );
  }
}
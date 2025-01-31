
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ссылка для сброса пароля отправлена на email')),
      );
      Navigator.pop(context);
    } catch (e) {
      print(e);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(title: Text('Сброс пароля')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Введите ваш email', style: TextStyle(fontSize: 18)),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Сбросить пароль'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
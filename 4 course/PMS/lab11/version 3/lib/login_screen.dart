import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginScreen({super.key});

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Запускаем Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // Пользователь отменил вход
        return;
      }

      // Получаем аутентификационные данные
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Создаем учетные данные для Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Аутентификация в Firebase
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Вывод email пользователя
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Добро пожаловать, ${user.email}!')),
        );
      }
    } catch (e) {
      print("Ошибка при входе с Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка при входе с Google')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signInWithGoogle(context),
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}

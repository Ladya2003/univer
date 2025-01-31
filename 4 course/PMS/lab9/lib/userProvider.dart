import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'models/user.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;


  Future<void> loadCurrentUser() async {
    final userBox = Hive.box<User>('users');
    final currentUserBox = Hive.box<int>('current_user');

    final userId = currentUserBox.get('currentUserId');
    if (userId != null) {

      _currentUser = userBox.values.firstWhereOrNull((user) => user.id == userId);
    }

    notifyListeners();
  }


  Future<void> setCurrentUser(User user) async {
    final currentUserBox = Hive.box<int>('current_user');
    await currentUserBox.put('currentUserId', user.id);
    _currentUser = user;
    notifyListeners();
  }

  Future<List<User>> getAllUsers() async {
    final userBox = Hive.box<User>('users');
    return userBox.values.toList();
  }
}

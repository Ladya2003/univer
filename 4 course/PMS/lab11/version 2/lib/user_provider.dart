import 'package:flutter/material.dart';
import '/service/userService.dart';
import '/models/user.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService;
  User? _currentUser;
  bool _isInitialized = false;

  UserProvider(this._userService);

  User? get currentUser => _currentUser;
  bool get isInitialized => _isInitialized;

  void loadCurrentUser() async {
    _currentUser = await _userService.getCurrentUser();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> changeUser(User user) async {
    _currentUser = user;
    await _userService.setCurrentUser(user.id);
    notifyListeners();
  }

  Future<List<User>> getAllUsers() async {
    return await _userService.getAllUsers();
  }
}


import 'package:hive/hive.dart';

import '../models/user.dart';

class UserService {
  final Box<User> _userBox = Hive.box<User>('users');
  final Box<int> _currentUserBox = Hive.box<int>('current_user'); // Храним ID пользователя

  Future<void> addUser(User user) async {
    await _userBox.add(user);
  }

  Future<void> setCurrentUser(User user) async {
    await _currentUserBox.put('currentUserId', user.id);
  }

  User getCurrentUser() {
    final userId = _currentUserBox.get('currentUserId');
    if (userId == null) {
      return _userBox.values.first;
    }
    return _userBox.values.firstWhere((user) => user.id == userId, orElse: () => _userBox.values.first);
  }

  Future<List<User>> getAllUsers() async {
    return _userBox.values.toList();
  }
}





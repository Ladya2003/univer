
import '../models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UserSelected extends UserState {
  final User user;
  UserSelected(this.user);
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}
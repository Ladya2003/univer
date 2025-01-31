
import '../models/user.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class LoadCurrentUser extends UserEvent {}

class SelectUser extends UserEvent {
  final User user;
  SelectUser(this.user);
}
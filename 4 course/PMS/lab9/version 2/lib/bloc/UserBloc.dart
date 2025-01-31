

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../event/UserEvent.dart';
import '../event/UserState.dart';
import '../models/user.dart';
import '../service/userService.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  bool usersLoaded = false;

  UserBloc(this.userService) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadCurrentUser>(_onLoadCurrentUser);
    on<SelectUser>(_onSelectUser);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    if (usersLoaded) {
      emit(state);  // Если пользователи уже загружены, сохраняем текущее состояние.
      return;
    }

    try {
      final users = await userService.getAllUsers();
      if (users.isNotEmpty) {
        usersLoaded = true; // Помечаем, что пользователи загружены.
        emit(UsersLoaded(users)); // Устанавливаем состояние с пользователями.
      } else {
        emit(UserError("No users found"));
      }
    } catch (e) {
      emit(UserError("Failed to load users"));
    }
  }

  Future<void> _onLoadCurrentUser(LoadCurrentUser event, Emitter<UserState> emit) async {
    try {
      final currentUserBox = Hive.box<int>('current_user');
      final userBox = Hive.box<User>('users');

      final userId = currentUserBox.get('currentUserId');
      if (userId != null) {
        final currentUser = userBox.values.firstWhereOrNull((user) => user.id == userId);
        if (currentUser != null) {
          emit(UserSelected(currentUser));
          return;
        }
      }
      emit(UserError("No current user found"));
    } catch (e) {
      emit(UserError("Failed to load current user"));
    }
  }

  Future<void> _onSelectUser(SelectUser event, Emitter<UserState> emit) async {
    await userService.setCurrentUser(event.user.id);
    emit(UserSelected(event.user));
  }
}


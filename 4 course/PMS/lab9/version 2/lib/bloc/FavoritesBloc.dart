
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../event/FavoritesEvent.dart';
import '../event/FavoritesState.dart';
import '../event/UserState.dart';
import '../models/favoriteItem.dart';
import '../models/product.dart';
import '../service/favoriteService.dart';
import '../service/userService.dart';
import 'UserBloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteService favoriteService;
  final UserBloc userBloc;

  // event handlers registration
  FavoritesBloc(this.favoriteService, this.userBloc) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  // set event FavoritesLoading, then loads user's fav's
  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      final currentUserState = userBloc.state;
      if (currentUserState is UserSelected) {
        final favorites = await favoriteService.getFavoritesForUser(currentUserState.user.id);
        // generate FavoritesLoaded event
        emit(FavoritesLoaded(favorites));
      } else {
        emit(FavoritesError("No user selected"));
      }
    } catch (e) {
      emit(FavoritesError("Failed to load favorites"));
    }
  }

  Future<void> _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) async {
    try {
      final currentUserState = userBloc.state;
      if (currentUserState is UserSelected) {
        await favoriteService.removeFavorite(currentUserState.user.id, event.productKey);
        add(LoadFavorites()); // Перезагружаем избранное после удаления
      } else {
        emit(FavoritesError("No user selected"));
      }
    } catch (e) {
      emit(FavoritesError("Failed to remove from favorites"));
    }
  }
}
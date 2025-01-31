import 'package:flutter/material.dart';
import '/service/favoriteService.dart';
import '/models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoriteService _favoriteService;
  List<Product> _favorites = [];
  bool _isLoading = false;

  FavoritesProvider(this._favoriteService);

  List<Product> get favorites => _favorites;
  bool get isLoading => _isLoading;

  void loadFavorites(int? userId) async {
    if (userId == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      _favorites = await _favoriteService.getFavoritesForUser(userId);
    } catch (e) {
      _favorites = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeFavorite(int userId, int productKey) async {
    await _favoriteService.removeFavorite(userId, productKey);
    loadFavorites(userId);
  }
}

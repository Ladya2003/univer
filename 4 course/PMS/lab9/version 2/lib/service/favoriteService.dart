// favorites_service.dart

import 'package:hive/hive.dart';

import '../models/favoriteItem.dart';
import '../models/product.dart';

class FavoriteService {
  final Box<FavoriteItem> _favoriteBox = Hive.box<FavoriteItem>('favorites');

  Future<void> addFavorite(int userId, int productId) async {
    if (!await isFavorite(userId, productId)) {
      final favorite = FavoriteItem(userId: userId, productId: productId);
      await _favoriteBox.add(favorite);
    }
  }

  Future<void> removeFavorite(int userId, int productId) async {
    try {
      final favorite = _favoriteBox.values.firstWhere(
            (f) => f.userId == userId && f.productId == productId,
        orElse: () => throw Exception("Favorite not found"),
      );
      await favorite.delete();
    } catch (e) {
      // Можно добавить обработку, если нужно, или оставить пустым
      print("Favorite not found, nothing to delete.");
    }
  }

  Future<List<Product>> getFavoritesForUser(int userId) async {
    List<int> favoriteProductIds = _favoriteBox.values
        .where((favorite) => favorite.userId == userId)
        .map((favorite) => favorite.productId)
        .toList();
    return Hive.box<Product>('products')
        .values
        .where((product) => favoriteProductIds.contains(product.key as int))
        .toList();
  }

  Future<bool> isFavorite(int userId, int productId) async {
    return _favoriteBox.values.any((favorite) => favorite.userId == userId && favorite.productId == productId);
  }
}


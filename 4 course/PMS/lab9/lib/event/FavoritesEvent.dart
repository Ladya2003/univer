

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class RemoveFromFavorites extends FavoritesEvent {
  final int productKey;
  RemoveFromFavorites(this.productKey);
}
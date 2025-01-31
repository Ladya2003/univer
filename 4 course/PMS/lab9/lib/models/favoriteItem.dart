import 'package:hive/hive.dart';
part 'favoriteItem.g.dart';

@HiveType(typeId: 2)
class FavoriteItem extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final int productId;

  FavoriteItem({required this.userId, required this.productId});
}

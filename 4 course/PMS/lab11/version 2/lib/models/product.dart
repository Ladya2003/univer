import 'package:hive/hive.dart';
part 'product.g.dart';


@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

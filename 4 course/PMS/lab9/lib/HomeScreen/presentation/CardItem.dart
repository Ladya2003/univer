import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ProductScreen/presentation/ProductInfo.dart';
import '../../models/product.dart';
import '../../service/favoriteService.dart';
import '../../service/userService.dart';
class CardItem extends StatefulWidget {
  final Product product;
  final FavoriteService favoriteService = FavoriteService();
  final UserService userService = UserService();

  CardItem({required this.product});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isFavorite = false; // Инициализация с помощью значения по умолчанию

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final currentUser = widget.userService.getCurrentUser();
    if (currentUser != null) {
      final productKey = widget.product.key as int?;
      if (productKey != null) {
        isFavorite = await widget.favoriteService.isFavorite(currentUser.id, productKey);
        setState(() {}); // Обновление состояния
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final currentUser = widget.userService.getCurrentUser();
    final productKey = widget.product.key as int?;
    if (currentUser != null && productKey != null) {
      if (isFavorite) {
        await widget.favoriteService.removeFavorite(currentUser.id, productKey);
      } else {
        await widget.favoriteService.addFavorite(currentUser.id, productKey);
      }
      setState(() {
        isFavorite = !isFavorite; // Переключение состояния
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : Colors.grey,
            onPressed: _toggleFavorite,
          ),
          Container(
            height: 85.0,
            width: 85.0,
            child: Image.asset(
              widget.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.name, style: TextStyle(fontSize: 16.0)),
                Text('\$${widget.product.price}', style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductInfo(
                        images: [widget.product.imageUrl],
                        description: widget.product.description,
                        textLeft: widget.product.name,
                        textRight: '\$${widget.product.price}',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('BUY'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

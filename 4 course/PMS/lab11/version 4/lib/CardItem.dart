import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../firebaseFirestore.dart';
import 'ProductInfo.dart';
import 'addProductCcreen.dart';
import 'editProductScreen.dart';





class CardItem extends StatefulWidget {
  final String productId;
  final String image;
  final String textLeft;
  final String textRight;
  final String description;

  CardItem({
    required this.productId,
    required this.image,
    required this.textLeft,
    required this.textRight,
    required this.description,
  });

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final FirestoreService _firestoreService = FirestoreService();
  bool isFavorite = false;
  bool isAdmin = true;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc('$userId\_${widget.productId}')
          .get();

      setState(() {
        isFavorite = favoritesSnapshot.exists;
      });
    }
  }

  void _toggleFavorite() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _firestoreService.toggleFavorite(
        productId: widget.productId,
        userId: userId,
      );
      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  void _deleteProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить товар'),
        content: Text('Вы уверены, что хотите удалить этот товар?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              _firestoreService.deleteProduct(widget.productId);
              Navigator.pop(context);
            },
            child: Text('Удалить'),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        height: 85.0,
        width: 85.0,
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: 85.0,
        width: 85.0,
      );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 20.0,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ),
              if (isAdmin)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddProductScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                              productId: widget.productId,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: _deleteProduct,
                    ),
                  ],
                ),
            ],
          ),
          _buildImage(widget.image),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(widget.textLeft, style: TextStyle(fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Цена: ${widget.textRight}', style: TextStyle(fontSize: 16.0)),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductInfo(
                        productId: widget.productId,
                        image: widget.image,
                        description: widget.description,
                        textLeft: widget.textLeft,
                        textRight: widget.textRight,
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

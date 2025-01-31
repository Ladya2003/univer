import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../firebaseFirestore.dart';
import 'CardItem.dart';


class BottomSheetBlock extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final bool isAdmin;

  BottomSheetBlock({required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.readProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return Container(
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ваши заголовки
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${products.length} Results',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[200]),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[100]),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return CardItem(
                      productId: product.id,
                      image: product['image'],
                      textLeft: product['name'],
                      textRight: product['price'].toString(),
                      description: product['description'],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebaseFirestore.dart';



class ProductInfo extends StatefulWidget {
  final String productId;
  final String image;
  final String description;
  final String textLeft;
  final String textRight;

  ProductInfo({
    required this.productId,
    required this.image,
    required this.description,
    required this.textLeft,
    required this.textRight,
  });

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  String selectedSize = '41';

  void _buyProduct() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      FirestoreService().createOrder({
        'productId': widget.productId,
        'size': selectedSize,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Заказ оформлен')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        title: Text('Product Details'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.textLeft, style: TextStyle(fontSize: 20.0)),
                            Text(widget.textRight, style: TextStyle(fontSize: 20.0)),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(widget.description, style: TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('CHOOSE THE SIZE',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ['41', '42', '43', '44'].map((size) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                label: Text(size),
                                selected: selectedSize == size,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {

                          },
                        ),
                        ElevatedButton(
                          onPressed: _buyProduct,
                          child: Text('BUY'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
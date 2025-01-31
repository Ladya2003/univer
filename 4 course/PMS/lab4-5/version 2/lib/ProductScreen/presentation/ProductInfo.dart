import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProductInfo extends StatelessWidget {
  final String image;
  final String description;
  final String textLeft;
  final String textRight;

  ProductInfo({
    required this.image,
    required this.description,
    required this.textLeft,
    required this.textRight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7F8CA2),
      appBar: AppBar(
        backgroundColor: Color(0xFF7F8CA2),
        title: Text('Product Details'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child:  Container(
              decoration: BoxDecoration(
              color: Colors.white, // Цвет фона второй части
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
                          Text(textLeft, style: TextStyle(fontSize: 20.0)),
                          Text(textRight, style: TextStyle(fontSize: 20.0)),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(description, style: TextStyle(fontSize: 12.0)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('CHOOSE THE SIZE', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        height: 100.0,
                        child: ListView(
                          children: [
                            for (var size in ['41 UK', '42 UK', '43 UK', '44 UK']) ...[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(child: Text(size, style: TextStyle(fontSize: 16.0))),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                        onPressed: () {
                        },
                        child: Text('BUY NOW'),
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
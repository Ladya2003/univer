import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../../ProductManagmentScreen.dart';
import '../../service/userService.dart';


class ProductInfo extends StatelessWidget {
  final List<String> images;
  final String description;
  final String textLeft;
  final String textRight;

  ProductInfo({
    required this.images,
    required this.description,
    required this.textLeft,
    required this.textRight,
  });

  static const platform = MethodChannel('com.example.lab4/channel');

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
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Container(
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
                        height: 50.0,
                        child: ListView(
                          children: [
                            for (var size in ['41', '42', '43', '44']) ...[
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
                        onPressed: () {},
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final currentUser = UserService().getCurrentUser();
                          if (currentUser.isAdminOrManager) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductManagementScreen(),
                              ),
                            );
                          } else {

                            print("User is not an admin or manager");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        ),
                        child: Text('BUY', style: TextStyle(fontSize: 16.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  final String label;

  CategoryItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.0),
          Text(label),
        ],
      ),
    );
  }
}
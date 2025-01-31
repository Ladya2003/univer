import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;

  const CategoryItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.center,
      child: Text(label),
    );
  }
}
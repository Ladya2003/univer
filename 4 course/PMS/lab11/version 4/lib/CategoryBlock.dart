

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryItem.dart';


class CategoryBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: double.infinity, // Указываем ширину
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          10,
              (index) => CategoryItem(label: 'Item $index'),
        ),
      ),
    );
  }
}
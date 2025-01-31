

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laba4/HomeScreen/presentation/CategoryItem.dart';

class CategoryBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryItem( label: 'Shoes'),
          CategoryItem( label: 'Glasses'),
          CategoryItem( label: 'Hats'),
          CategoryItem( label: 'Belts'),
        ],
      ),
    );
  }
}
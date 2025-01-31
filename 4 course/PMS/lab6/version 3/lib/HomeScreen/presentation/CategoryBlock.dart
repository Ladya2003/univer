

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/HomeScreen/presentation/CategoryItem.dart';

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryItem( label: 'Shoes'),
          CategoryItem( label: 'Glasses'),
          CategoryItem( label: 'Hats'),
          CategoryItem( label: 'Belts'),
        ],
      ),
    );
  }
}
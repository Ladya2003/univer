import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Icon(
        Icons.home,
        size: 48.0,
        color: Colors.white,
      ),
    );
  }
}

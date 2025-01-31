import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Puma',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
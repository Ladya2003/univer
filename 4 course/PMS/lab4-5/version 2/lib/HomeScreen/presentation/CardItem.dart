import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/ProductScreen/presentation/ProductInfo.dart';

class CardItem extends StatelessWidget {
  final IconData heartIcon;
  final String image;
  final String textLeft;
  final String textRight;
  final String description;


 CardItem({
    required this.heartIcon,
    required this.image,
    required this.textLeft,
    required this.textRight,
   required this.description,

  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 12.0,
              backgroundColor: Colors.grey,
              child: Icon(heartIcon, color: Colors.white, size: 14.0),
            ),
          ),
          Container(
            height: 85.0,
            width: 85.0,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(textLeft, style: TextStyle(fontSize: 16.0)),
                Text(textRight, style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(textLeft, style: TextStyle(fontSize: 12.0)),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductInfo(
                        image: image,
                        description: description,
                        textLeft: textLeft,
                        textRight: textRight,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('BUY'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



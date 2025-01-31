import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laba4/ProductScreen/presentation/ProductInfo.dart';

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

  static const platform = MethodChannel('com.example.lab4/channel');

  Future<void> _sendEmail(String subject, BuildContext context) async {
    try {
      await platform.invokeMethod('sendEmail', {'subject': subject});
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка: ${e.message}")),
      );
    }
  }




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
              child:  IconButton(
                icon: Icon(heartIcon, size: 14.0),
                color: Colors.grey,
                onPressed: () {
                  _sendEmail("Лайк на продукт: $textLeft", context);
                },
              ),
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
                        images: ['assets/images/puma1.png', 'assets/images/puma2.png', 'assets/images/puma3.png'],
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



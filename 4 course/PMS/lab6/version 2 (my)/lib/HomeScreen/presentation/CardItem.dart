import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/ProductScreen/presentation/ProductInfo.dart';

class CardItem extends StatelessWidget {
  final IconData heartIcon;
  final String image;
  final String textLeft;
  final String textRight;
  final String description;


 const CardItem({super.key, 
    required this.heartIcon,
    required this.image,
    required this.textLeft,
    required this.textRight,
   required this.description,

  });

  static const platform = MethodChannel('com.example.lab6/channel');

  Future<void> openBrowser(String url, BuildContext context) async {
    try {
      await platform.invokeMethod('openBrowser', {'url': url});
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
        boxShadow: const [
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
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 12.0,
              backgroundColor: Colors.grey,
              child:  IconButton(
                icon: Icon(heartIcon, size: 14.0),
                color: Colors.grey,
                onPressed: () {
                  openBrowser("https://example.com", context);
                },
              ),
            ),
          ),
          SizedBox(
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
                Text(textLeft, style: const TextStyle(fontSize: 16.0)),
                Text(textRight, style: const TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(textLeft, style: const TextStyle(fontSize: 12.0)),
          ),
          const Spacer(),
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
                        images: const ['assets/images/puma1.png', 'assets/images/puma2.png', 'assets/images/puma3.png'],
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
                child: const Text('BUY'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



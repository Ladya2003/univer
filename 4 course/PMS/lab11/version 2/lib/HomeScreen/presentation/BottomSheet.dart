import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/HomeScreen/presentation/CardItem.dart';
import '/models/product.dart';
import '/service/productService.dart';


class BottomSheetBlock extends StatelessWidget {
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '32 Results',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blueGrey[200]),
              ),
              Text(
                'See All',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blueGrey[100]),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          // Expanded(
          //   child: FutureBuilder<List<Product>>(
          //     future: productService.getAllProducts(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) return CircularProgressIndicator();
          //       return GridView.builder(
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 8.0,
          //           mainAxisSpacing: 8.0,
          //           childAspectRatio: 0.7,
          //         ),
          //         itemCount: snapshot.data!.length,
          //         itemBuilder: (context, index) {
          //           return CardItem(product: snapshot.data![index]);
          //         },
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: productService.watchAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products available'));
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CardItem(product: snapshot.data![index]);
                  },
                );
              },
            ),
          )


        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/HomeScreen/presentation/CardItem.dart';


class BottomSheetBlock extends StatelessWidget {
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
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFF7F8CA2)),
              ),
              Text(
                'See All',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF7F8CA2)),
              ),
            ],
          ),

          SizedBox(height: 20.0),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return CardItem(
              heartIcon: Icons.favorite,
              image: 'assets/images/puma${index + 1}.png',
              textLeft: 'PUMA MODEL',
              textRight: '94 \$',
              description: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which dont anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. ',
              );
          },
        ),
      ),
        ],
      ),
    );
  }
}
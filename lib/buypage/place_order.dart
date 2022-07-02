import 'package:flutter/material.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:50,
      child: Column(
        children:  const [
          Text('Buy this item'),
        ],
      ),
    );
  }
}

import 'package:clothing_waste_app/products/product_card.dart';
import 'package:flutter/material.dart';

int numberColumns = 2;

class RecentlyAddedPage extends StatelessWidget {
  const RecentlyAddedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numberColumns,
      ),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: clickItem,
          child: Container(
            margin: const EdgeInsets.all(7.5),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent)),
            child: const ProductCard(),
          ),
        );
      },
    ));
  }
}

void clickItem() {}

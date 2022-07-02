import 'package:clothing_waste_app/products/product_card.dart';
import 'package:flutter/material.dart';

const int numberColumns = 2;

class ProductsPage extends StatelessWidget {
  final List<ProductCard> products;

  const ProductsPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numberColumns,
          childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
        ),
        itemCount: 12,//The size of the products list
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: null,
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
      ),
    );
  }
}
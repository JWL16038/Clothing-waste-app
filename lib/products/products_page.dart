import 'package:clothing_waste_app/products/product_card.dart';
import 'package:clothing_waste_app/utils/notifications.dart';
import 'package:flutter/material.dart';

const int numberColumns = 2;

class ProductsPage extends StatelessWidget {
  final List<ProductCard> products;

  const ProductsPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(
            child: Text('Products list is empty'),
          )
        : Scaffold(
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberColumns,
                childAspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(7.5),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent)),
                  child: products[index],
                );
              },
            ),
          );
  }
}

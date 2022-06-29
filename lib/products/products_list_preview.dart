import 'package:clothing_waste_app/products/product_card.dart';
import 'package:flutter/material.dart';

class ProductsListPreview extends StatelessWidget {
  const ProductsListPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const ProductCard();
        });
  }
}

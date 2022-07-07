import 'package:clothing_waste_app/products/product_card.dart';
import 'package:flutter/material.dart';

class ProductsListPreview extends StatelessWidget {
  final List<ProductCard> products;

  const ProductsListPreview({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length > 3 ? 3 : products.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return products[index];
      },
    );
  }
}

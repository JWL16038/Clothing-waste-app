import 'package:clothing_waste_app/animations/slide.dart';
import 'package:clothing_waste_app/products/product_details.dart';
import 'package:flutter/material.dart';

import '../database/item_model.dart';

class ProductCard extends StatelessWidget {
  final Item item;

  const ProductCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            SwipeLeftRoute(page: const ProductDetails()),
          );
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('"${item.caption}"'),
                ),
              ),
              Image(
                image: NetworkImage(item.photoUrl),
                width: 100,
                height: 100,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Item name: ${item.itemName}'),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Description: ${item.itemDesc}'),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Price: ${item.price}'),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Colour: ${item.colour}'),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Size: ${item.size}'),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Condition: ${item.condition}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

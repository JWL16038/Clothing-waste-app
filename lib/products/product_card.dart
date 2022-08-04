import 'package:clothing_waste_app/animations/slide.dart';
import 'package:clothing_waste_app/products/product_details.dart';
import 'package:flutter/material.dart';

import '../database/item_model.dart';

class ProductCard extends StatelessWidget {
  final Item item;
  final String userUID;
  final String itemID;

  const ProductCard(
      {Key? key,
      required this.item,
      required this.userUID,
      required this.itemID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Image url ${item.photoUrl}");
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            SwipeLeftRoute(
              page: ProductDetails(
                item: item,
                userUID: userUID,
                itemID: itemID,
              ),
            ),
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
                  child: Text('Item name: ${item.itemName}'),
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
                  child: Text('"${item.caption}"'),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: Text('Price: \$${item.price}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

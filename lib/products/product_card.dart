import 'package:clothing_waste_app/animations/slide.dart';
import 'package:clothing_waste_app/products/product_details.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

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
              const Image(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                width: 100,
                height: 100,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: const Text("Item name: xxx"),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: const Text("Price: xxx"),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: const Text("Size: xxx"),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 2, 30, 2),
                  child: const Text("Condition: xxx"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

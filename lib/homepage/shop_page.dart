import 'package:clothing_waste_app/searchbar/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../items/user_items.dart';
import '../products/product_card.dart';
import '../products/products_page.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchBar(),
      body: FutureBuilder(
        future: generateRandomItems(50),
        builder: (BuildContext context, AsyncSnapshot<List<ProductCard>> list) {
          if (list.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ProductsPage(products: list.requireData);
        },
      ),
    );
  }
}

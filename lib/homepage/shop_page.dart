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
    List<ProductCard> productsList = [];

    return Scaffold(
      appBar: SearchBar(),
      body: StreamBuilder(
          stream: getAllOtherItems(_auth.currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            productsList.clear();
            for (QueryDocumentSnapshot data in snapshot.data!.docs) {
              productsList
                  .add(convertDocSnapToItems(data, data.reference.parent.id));
            }
            return ProductsPage(products: productsList);
          }),
    );
  }
}

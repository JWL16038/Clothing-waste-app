import 'dart:math';

import 'package:clothing_waste_app/items/user_items.dart';
import 'package:clothing_waste_app/products/products_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/item_model.dart';
import '../products/product_card.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductCard> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: getAllOtherItems(_auth.currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            cartList.clear();
            for (QueryDocumentSnapshot data in snapshot.data!.docs) {
              cartList.add(
                  convertDocSnapToItems(data,data.reference.parent.id)
              );
            }
            return ProductsPage(products: cartList);
          }),
    );
  }
}

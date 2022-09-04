import 'package:clothing_waste_app/products/products_list_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../animations/slide.dart';
import '../items/user_items.dart';
import '../products/product_card.dart';
import '../products/products_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductCard> recentlyList = [];
  List<ProductCard> forSaleList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    forSaleList.clear();
    recentlyList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: false,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Column(
              children: [
                /*
                Featured items
                 */
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Featured items",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          SwipeLeftRoute(
                            page: const ProductsPage(
                              products: [],
                            ),
                          ),
                        );
                      },
                      child: const Text("See more"),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: const ProductsListPreview(
                    products: [],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                /*
               Recently added section
               */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recently added",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          SwipeLeftRoute(
                            page: ProductsPage(
                              products: recentlyList,
                            ),
                          ),
                        );
                      },
                      child: const Text("See more"),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: StreamBuilder(
                    stream: getRecentlyAddedItems(_auth.currentUser!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      recentlyList.clear();
                      // for (QueryDocumentSnapshot data in snapshot.data!.docs) {
                      //   recentlyList.add(convertDocSnapToItems(
                      //       data, data.reference.parent.id));
                      // }
                      return ProductsListPreview(
                        products: recentlyList,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

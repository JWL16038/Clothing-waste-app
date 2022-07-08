import 'package:clothing_waste_app/products/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../items/user_items.dart';
import '../products/products_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String photoURL = "";
  int watchers = 0;
  int itemsForSale = 0;
  List<ProductCard> itemsList = [];

  void getUserdata() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnap =
        await FirebaseFirestore.instance.collection('users').doc(userUID).get();

    List watchersList = (userSnap.data() as Map<String, dynamic>)['watchers'];
    List feedbackList = (userSnap.data() as Map<String, dynamic>)['feedback'];

    itemsList = await getItemsForSale();
    if (mounted) {
      setState(() {
        username = (userSnap.data() as Map<String, dynamic>)['username'];
        photoURL = (userSnap.data() as Map<String, dynamic>)['photoUrl'];
        watchers = watchersList.length;
        itemsForSale = itemsList.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserdata();
  }

  @override
  void dispose() {
    super.dispose();
    itemsList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(photoURL),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Username:  $username'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$itemsForSale items for sale',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$watchers watchers",
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "xxx% reputation",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
            child: itemsForSale == 0
                ? const Center(
                    child: Text('No items found.'),
                  )
                : const Center(
                    child: Text(
                      'Your items for sale: ',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: ProductsPage(
              products: itemsList,
            ),
          ),
        ],
      ),
    );
  }
}

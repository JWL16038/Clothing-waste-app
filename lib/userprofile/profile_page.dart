import 'package:clothing_waste_app/products/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../items/user_items.dart';
import '../products/products_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
    String userUID = _auth.currentUser!.uid;

    DocumentSnapshot userSnap =
        await FirebaseFirestore.instance.collection('users').doc(userUID).get();

    if (mounted) {
      setState(() {
        username = (userSnap.data() as Map<String, dynamic>)['username'];
        photoURL = (userSnap.data() as Map<String, dynamic>)['photoUrl'];
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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('items')
                          .doc('forsale')
                          .collection(_auth.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        return Text(
                          '${snapshot.data?.size} items for sale',
                        );
                      },
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('items')
                  .doc('forsale')
                  .collection(_auth.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                return Center(
                  child: Text(
                    snapshot.data?.size == 0
                        ? 'No items found'
                        : 'Your items for sale: ',
                  ),
                );
              },
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: StreamBuilder(
              stream: getItemsForSale(_auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                itemsList.clear();
                for (QueryDocumentSnapshot data in snapshot.data!.docs) {
                  itemsList.add(
                      convertDocSnapToItems(data,data.reference.parent.id)
                  );
                }
                return ProductsPage(
                  //products: list,
                  products: itemsList,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

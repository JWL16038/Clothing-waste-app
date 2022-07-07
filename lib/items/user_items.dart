import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/item_model.dart';
import '../products/product_card.dart';

Future<List<ProductCard>> getItemsForSale() async {
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot result = await FirebaseFirestore.instance
      .collection('items')
      .doc(userUID)
      .collection('forsale')
      .get();

  List<ProductCard> itemsList = [];
  for (DocumentSnapshot doc in result.docs) {
    Item item = Item(
      caption: doc['caption'],
      itemName: doc['itemName'],
      itemDesc: doc['itemDesc'],
      price: int.parse(doc['price']),
      photoUrl: doc['photoUrl'],
      colour: doc['colour'],
      condition: doc['condition'],
      size: int.parse(doc['size']),
    );

    itemsList.add(
      ProductCard(
        item: item,
      ),
    );
  }
  return itemsList;
}

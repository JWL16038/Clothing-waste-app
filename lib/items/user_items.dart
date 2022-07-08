import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/item_model.dart';
import '../products/product_card.dart';

Item convertDocToItem(DocumentSnapshot doc) {
  return Item(
    caption: doc['caption'],
    itemName: doc['itemName'],
    itemDesc: doc['itemDesc'],
    price: doc['price'],
    photoUrl: doc['photoUrl'],
    colour: doc['colour'],
    condition: doc['condition'],
    size: doc['size'],
    adddate: doc['adddate'],
  );
}

Future<List<ProductCard>> getItemsForSale() async {
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot result = await FirebaseFirestore.instance
      .collection('items')
      .doc(userUID)
      .collection('forsale')
      .get();

  List<ProductCard> itemsList = [];
  for (DocumentSnapshot doc in result.docs) {
    itemsList.add(
      ProductCard(
        item: convertDocToItem(doc),
      ),
    );
  }
  return itemsList;
}

Future<List<ProductCard>> getRecentlyAdded() async {
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  QuerySnapshot result = await FirebaseFirestore.instance
      .collection('items')
      .get();

  List<ProductCard> itemsList = [];
  for (DocumentSnapshot doc in result.docs) {
    if(doc.id == userUID) continue;
    // doc.reference.collection('forsale').get()
    itemsList.add(
      ProductCard(
        item: convertDocToItem(doc),
      ),
    );
  }
  return itemsList;
}

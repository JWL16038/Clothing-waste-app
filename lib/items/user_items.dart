import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/item_model.dart';
import '../products/product_card.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

Future<List<ProductCard>> getItemsForSale(String userUID) async {
  List<ProductCard> itemsList = [];

  QuerySnapshot result = await _firestore
      .collection('items')
      .doc(userUID)
      .collection('forsale')
      .get();

  if (result.size == 0) return itemsList;

  for (DocumentSnapshot doc in result.docs) {
    itemsList.add(
      ProductCard(
        item: convertDocToItem(doc),
      ),
    );
  }
  return itemsList;
}

Future<List<ProductCard>> getRecentlyAdded(String userUID) async {
  List<ProductCard> itemsList = [];

  QuerySnapshot result = await _firestore.collection('users').get();

  if (result.size == 0) return itemsList;

  for (DocumentSnapshot doc in result.docs) {
    if (doc.id == userUID) continue;

    QuerySnapshot result2 = await _firestore
        .collection('items')
        .doc(doc.id)
        .collection('forsale')
        .get();

    for (DocumentSnapshot itemDoc in result2.docs) {
      itemsList.add(
        ProductCard(
          item: convertDocToItem(itemDoc),
        ),
      );
    }
  }
  itemsList.sort(
    (itemA, itemB) => DateTime.parse(itemB.item.adddate).compareTo(
      DateTime.parse(itemA.item.adddate),
    ),
  );
  return itemsList;
}

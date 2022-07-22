import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/item_model.dart';
import '../products/product_card.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

Item _convertDocToItem(DocumentSnapshot doc) {
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

List<ProductCard> _convertSnapshotToItems(
    QuerySnapshot<Map<String, dynamic>> data, String userUID) {
  List<ProductCard> itemsList = [];

  if (data.size == 0) return itemsList;

  for (DocumentSnapshot doc in data.docs) {
    itemsList.add(
      ProductCard(
        item: _convertDocToItem(doc),
        userUID: userUID,
      ),
    );
  }
  return itemsList;
}

ProductCard convertDocSnapToItems(
    QueryDocumentSnapshot data, String userUID) {

  if(data == null) throw Exception("No item provided");

  return ProductCard(
    item: _convertDocToItem(data),
    userUID: userUID,
  );
}

// Future<List<ProductCard>> getRecentlyAdded(String userUID) async {
//   List<ProductCard> itemsList = [];
//
//   QuerySnapshot result = await _firestore.collection('users').get();
//
//   if (result.size == 0) return itemsList;
//
//   for (DocumentSnapshot doc in result.docs) {
//     if (doc.id == userUID) continue;
//
//     QuerySnapshot result2 = await _firestore
//         .collection('items')
//         .doc(doc.id)
//         .collection('forsale')
//         .get();
//
//     for (DocumentSnapshot itemDoc in result2.docs) {
//       itemsList.add(
//         ProductCard(
//           item: _convertDocToItem(itemDoc),
//           userUID: userUID,
//         ),
//       );
//     }
//   }
//   itemsList.sort(
//     (itemA, itemB) => DateTime.parse(itemB.item.adddate).compareTo(
//       DateTime.parse(itemA.item.adddate),
//     ),
//   );
//   return itemsList;
// }

Future<List<String>> _getOtherUserUIDs(String userUID) async {
  QuerySnapshot uidsSnap = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isNotEqualTo: userUID)
      .get();
  List<String> uids = [];
  uidsSnap.docs.forEach((element) {
    uids.add(element.id);
  });
  return uids;
}

/// Gets all the recently added items
/// Gets all items that were posted by all users except the current user, sort items by added date and then pick the 30 most recent items
Stream<QuerySnapshot<Map<String, dynamic>>> getRecentlyAddedItems(userUID) async* {
  List<QuerySnapshot<Map<String, dynamic>>> snaps = [];
  List<String> uids = await _getOtherUserUIDs(userUID);
  for (var uid in uids) {
    snaps.add(await FirebaseFirestore.instance
        .collection('items')
        .doc('forsale')
        .collection(uid)
        .orderBy('adddate')
        .limit(2)
        .get());
  }
  yield* Stream.fromIterable(snaps);
}

Stream<QuerySnapshot<Map<String, dynamic>>> getAllOtherItems(userUID) async* {
  List<QuerySnapshot<Map<String, dynamic>>> snaps = [];
  List<String> uids = await _getOtherUserUIDs(userUID);
  for (var uid in uids) {
    snaps.add(await FirebaseFirestore.instance
        .collection('items')
        .doc('forsale')
        .collection(uid)
        .orderBy('adddate')
        .get());
  }
  yield* Stream.fromIterable(snaps);
}

Stream<QuerySnapshot<Map<String, dynamic>>> getItemsForSale(String userUID) async* {
  List<QuerySnapshot<Map<String, dynamic>>> snaps = [];

  snaps.add(await FirebaseFirestore.instance
      .collection('items')
      .doc('forsale')
      .collection(userUID)
      .get());

  yield* Stream.fromIterable(snaps);
}


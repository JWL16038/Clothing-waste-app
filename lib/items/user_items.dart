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

ProductCard convertQueryDocSnapToItems(
    QueryDocumentSnapshot data, String userUID) {
  return ProductCard(
    item: _convertDocToItem(data),
    userUID: userUID,
    itemID: data.id,
  );
}

ProductCard convertDocSnapToItems(DocumentSnapshot data, String userUID) {
  return ProductCard(
    item: _convertDocToItem(data),
    userUID: userUID,
    itemID: data.id,
  );
}

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
Stream<QuerySnapshot<Map<String, dynamic>>> getRecentlyAddedItems(
    String userUID) async* {
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

Stream<QuerySnapshot<Map<String, dynamic>>> getAllOtherItems(
    String userUID) async* {
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

bool addItemToCart(String userUID, String sellerUID, String itemID) {
  Map<String, dynamic> dataJson() => {
        "itemID": itemID,
        "seller": sellerUID,
        "addCartDate": DateTime.now().toString(),
      };

  _firestore
      .collection('items')
      .doc('cart')
      .collection(userUID)
      .doc() //Change the document name to be auto-incremental
      .set(dataJson());
  return true;
}

Future<List<ProductCard>> getCartItems(String userUID) async {
  List<ProductCard> cards = [];
  QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
      .collection('items')
      .doc('cart')
      .collection(userUID)
      .orderBy('addCartDate')
      .get();
  for (QueryDocumentSnapshot snap in query.docs) {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('items')
        .doc('forsale')
        .collection(snap['seller'])
        .doc(snap['itemID'])
        .get();
    cards.add(convertDocSnapToItems(doc, snap['seller']));
  }
  return cards;
}

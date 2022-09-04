import 'dart:math';

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

  yield* Stream.fromIterable(snaps);
}

/// Gets all
Future<List<QuerySnapshot<Map<String, dynamic>>>> getAllOtherItems(
    String userUID) async {
  List<QuerySnapshot<Map<String, dynamic>>> tempList = [];
  List<String> uids = await _getOtherUserUIDs(userUID);

  return tempList;
}

///Gets all items that were posted by this user
Stream<QuerySnapshot<Map<String, dynamic>>> getCurUserItems(
    String userUID) async* {
  yield* FirebaseFirestore.instance
      .collection('items')
      .doc('forsale')
      .collection(userUID)
      .snapshots();
}

///Add an item posted by a specific user to the current user's cart
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

///Get all cart items for a specific user
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

Future<List<ProductCard>> generateRandomItems(int numItems) async {
  final now = DateTime.now();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  List<String> uids = await _getOtherUserUIDs(_auth.currentUser!.uid);
  return List<ProductCard>.generate(
    numItems,
    (index) => ProductCard(
      item: Item(
        caption: "Lorem ipsum",
        itemName: String.fromCharCodes(Iterable.generate(
            10, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))),
        itemDesc: "Lorem ipsum",
        price: 12,
        photoUrl:
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
        colour: "Red",
        condition: "",
        size: 12,
        adddate: now.toString(),
      ),
      userUID: uids[_rnd.nextInt(uids.length)],
      itemID: String.fromCharCodes(Iterable.generate(
          20, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))),
    ),
  );
}

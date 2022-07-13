import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/item_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return TextButton(
      onPressed: () {
        Item item = Item(
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
        );

        _firestore
            .collection('items')
            .doc(_auth.currentUser!.uid)
            .collection('forsale')
            .doc()
            .set(
              item.toJson(),
            );
      },
      child: const Text('Add item'),
    );
  }
}

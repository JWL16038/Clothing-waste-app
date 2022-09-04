import 'dart:math';

import 'package:clothing_waste_app/authentication/login_page.dart';
import 'package:clothing_waste_app/authentication/authentication_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/item_model.dart';
import '../utils/notifications.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return Scaffold(
      appBar: AppBar(title: const Text("Side bar")),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
            child: Text("Sidebar header"),
          ),
          MaterialButton(
            onPressed: () async {
              await AuthMethods().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
              showSnackBar("Signed out successfully", context);
            },
            child: const Text("Sign out"),
          ),
          TextButton(
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

              FirebaseFirestore.instance
                  .collection('items')
                  .doc('forsale')
                  .collection(FirebaseAuth.instance.currentUser!.uid)
                  .doc()
                  .set(
                    item.toJson(),
                  );
            },
            child: const Text('Add item'),
          ),
        ],
      ),
    );
  }
}

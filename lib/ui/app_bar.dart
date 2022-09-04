import 'package:clothing_waste_app/messaging/messaging_main.dart';
import 'package:clothing_waste_app/ui/global_keys.dart';
import 'package:flutter/material.dart';

class AppBarApp extends StatelessWidget with PreferredSizeWidget {
  const AppBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    title: const Text("App bar"),

    );
  }

  @override
 Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// IconButton(
// icon: const Icon(Icons.message_outlined),
// onPressed: () {
// Navigator.of(context).pushReplacement(
// MaterialPageRoute(
// builder: (context) => const MessagingPage(),
// ),
// );
// },
// ),

import 'package:clothing_waste_app/messaging/messaging_main.dart';
import 'package:clothing_waste_app/ui/side_bar.dart';
import 'package:flutter/material.dart';

class AppBar_app extends StatelessWidget with PreferredSizeWidget{
  const AppBar_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Title bar"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.message_outlined),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MessagingPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

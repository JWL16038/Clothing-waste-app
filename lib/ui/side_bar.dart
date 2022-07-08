import 'package:clothing_waste_app/authentication/login_page.dart';
import 'package:flutter/material.dart';

import '../authentication/signout.dart';
import '../utils/notifications.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                await signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
                showSnackBar("Signed out successfully", context);
              },
              child: const Text("Sign out"),
            ),
          ],
        ));
  }
}

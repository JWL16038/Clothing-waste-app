import 'package:flutter/material.dart';
import 'package:clothing_waste_app/authentication/signout.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () => signOut(),
        child: const Text("Sign out"),
      ),
    );
  }
}

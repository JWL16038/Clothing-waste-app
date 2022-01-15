import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App bar")),
      body: const MaterialButton(
          onPressed: buttonPress,
          child: Text("Button 1"),
        ),
    );
  }
}


void buttonPress(){

}

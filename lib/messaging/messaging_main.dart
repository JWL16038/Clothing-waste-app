import 'package:flutter/material.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Direct Messaging"),
      ),
      body: ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              title: Text("Message no $index"),
            );
          },
      ),
    );
  }
}

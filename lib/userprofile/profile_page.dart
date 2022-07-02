
import 'package:clothing_waste_app/userprofile/profile_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username;
  String photoURL;

  void getUserName() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).get();

    setState((){
      username = (snap.data() as Map<String,dynamic>)['username'];
      photoURL = (snap.data() as Map<String,dynamic>)['photoUrl'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(photoURL),
                width: 100,
                height: 100,
                alignment: Alignment.topCenter,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(username),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "xxx items for sale",
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  " followers",
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "xxx% reputation",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'Your items for sale',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 30,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent)),
                  child: GridTile(
                    child: Center(
                      child: Text(
                        'Item $index',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

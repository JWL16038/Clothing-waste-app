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
  String username = "";
  String photoURL = "";
  int watchers = 0;
  int itemsForSale = 0;

  void getUserdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    List watchersList = (snap.data() as Map<String, dynamic>)['watchers'];
    List feedbackList = (snap.data() as Map<String, dynamic>)['feedback'];
    List itemsList = (snap.data() as Map<String, dynamic>)['items'];

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      photoURL = (snap.data() as Map<String, dynamic>)['photoUrl'];
      watchers = watchersList.length;
      itemsForSale = itemsList.length;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserdata();
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
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(photoURL),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Username:  $username'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$itemsForSale items for sale',
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$watchers watchers",
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "xxx% reputation",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
            child: itemsForSale == 0
                ? const Center(
                    child: Text('No items found.'),
                  )
                : const Center(
                    child: Text(
                      'Your items for sale: ',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: itemsForSale == 0 ? 0 : itemsForSale,
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

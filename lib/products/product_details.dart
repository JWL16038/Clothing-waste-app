import 'package:clothing_waste_app/buypage/place_order.dart';
import 'package:clothing_waste_app/homepage/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../animations/slide.dart';
import '../database/item_model.dart';
import '../homepage/buy_page.dart';

class ProductDetails extends StatefulWidget {
  final Item item;
  final String userUID;

  const ProductDetails(
      {Key? key, required this.item, required String this.userUID})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String curUserUID;

  @override
  void initState() {
    super.initState();
    curUserUID = _auth.currentUser!.uid;
    print(curUserUID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Item name: ${widget.item.itemName}',
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image(
                  image: NetworkImage(widget.item.photoUrl),
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Price: \$${widget.item.price}"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Condition: ${widget.item.condition}"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Size: ${widget.item.size}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Sizing chart'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("Colour: ${widget.item.colour}"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          //temporary, colour will changed based on value given by the item object.
                          borderRadius: BorderRadius.all(Radius.circular(7.5)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      "Details: ${widget.item.itemDesc}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                curUserUID != widget.userUID
                    ? OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            SwipeLeftRoute(
                              page: const BuyPage(),
                            ),
                          );
                        },
                        child: const Text('Add to cart'),
                      )
                    : Container(),
                // OutlinedButton(
                //   onPressed: () {},
                //   child: const Text('Swap with this item'),
                // ),

                const SizedBox(
                  height: 40,
                ),
                //Seller info here
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:clothing_waste_app/buypage/place_order.dart';
import 'package:flutter/material.dart';

import '../animations/slide.dart';
import '../database/item_model.dart';
import '../homepage/buy_page.dart';

class ProductDetails extends StatelessWidget {
  final Item item;

  const ProductDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(item.photoUrl);
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
                    'Item name: ${item.itemName}',
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image(
                  image: NetworkImage(item.photoUrl),
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Price: \$${item.price}"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Condition: ${item.condition}"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Size: ${item.size}",
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
                      child: Text("Colour: ${item.colour}"),
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
                      "Details: ${item.itemDesc}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Center(
                    //child: Text("Location: 123 Lorem ipsum street,"),
                    ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      SwipeLeftRoute(
                        page: const BuyPage(),
                      ),
                    );
                  },
                  child: const Text('Buy this item'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Swap with this item'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

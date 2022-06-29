import 'package:clothing_waste_app/buypage/place_order.dart';
import 'package:flutter/material.dart';

import '../animations/slide.dart';
import '../homepage/buy_page.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

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
                const Center(
                  child: Text(
                    "Item name here",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Image(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text("Price: \$0.0"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text("Condition: Brand new"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Size: XXX",
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
                    const Center(
                      child: Text("Colour: "),
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
                          borderRadius: BorderRadius.all(Radius.circular(7.5)),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      "Details: Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna. Nunc viverra imperdiet enim. Fusce est. Vivamus a tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin pharetra nonummy pede. Mauris et orci. Aenean nec lorem.",
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
                      SlideRoute(
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

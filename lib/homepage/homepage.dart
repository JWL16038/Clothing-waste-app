import 'package:clothing_waste_app/products/products_list_preview.dart';
import 'package:clothing_waste_app/products/featured_page.dart';
import 'package:clothing_waste_app/products/recently_added_list.dart';
import 'package:clothing_waste_app/products/recently_added_page.dart';
import 'package:flutter/material.dart';

import '../animations/slide.dart';
import '../items/user_items.dart';
import '../products/product_card.dart';
import '../products/products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductCard> forSaleList = [];

  void getItems() async{
    forSaleList = await getItemsForSale();

    setState(()  {

    });
  }

  @override
  void initState(){
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      reverse: false,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Column(
            children: [
              //const SearchBar(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Featured items",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        SwipeLeftRoute(
                          page: const ProductsPage(
                            products: [],
                          ),
                        ),
                      );
                    },
                    child: const Text("See more"),
                  ),
                ],
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: const ProductsListPreview(
                  products: [],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recently added",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        SwipeLeftRoute(
                          page: const ProductsPage(
                            products: [],
                          ),
                        ),
                      );
                    },
                    child: const Text("See more"),
                  ),
                ],
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: const ProductsListPreview(
                  products: [],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top sellers",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        SwipeLeftRoute(
                          page: ProductsPage(
                            products: [],
                          ),
                        ),
                      );
                    },
                    child: const Text("See more"),
                  ),
                ],
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: ProductsListPreview(
                  products: [],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your items for sale",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        SwipeLeftRoute(
                          page: ProductsPage(
                            products: forSaleList,
                          ),
                        ),
                      );
                    },
                    child: const Text("See more"),
                  ),
                ],
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: ProductsListPreview(
                  products: forSaleList,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

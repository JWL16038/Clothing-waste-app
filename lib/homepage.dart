import 'package:clothing_waste_app/Products/featured_cardview.dart';
import 'package:clothing_waste_app/Products/featured_page.dart';
import 'package:clothing_waste_app/searchbar/search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Route moreFeaturedItems() {
    return PageRouteBuilder(
        pageBuilder: (context,animation,secondaryAnimation) => const FeaturedPage(),
        transitionsBuilder: (context, animation,secondaryAnimation,child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
    );
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
                  const SizedBox(height: 30),
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
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(moreFeaturedItems());
                        },
                        child: const Text("See more"),
                      )
                    ],
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const ProductsCardList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Recently added",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: null,
                        child: Text("See more"),
                      )
                    ],
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const ProductsCardList(),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}


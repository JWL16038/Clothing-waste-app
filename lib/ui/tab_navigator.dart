import 'package:clothing_waste_app/userprofile/profile_page.dart';
import 'package:clothing_waste_app/homepage/shop_page.dart';
import 'package:clothing_waste_app/items/add_page.dart';
import 'package:flutter/material.dart';

import '../homepage/homepage.dart';
import '../homepage/cart_page.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  const TabNavigator({Key? key, this.navigatorKey, this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (tabItem) {
      case "homepage":
        child = const HomePage();
        break;
      case "shop":
        child = const ShopPage();
        break;
      case "add":
        child = const AddPage();
        break;
      case "cart":
        child = const CartPage();
        break;
      case "profile":
        child = const ProfilePage();
        break;
      default:
        child = const HomePage();
        break;//dead code
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

import 'package:clothing_waste_app/userprofile/profile_page.dart';
import 'package:clothing_waste_app/tabitems/shop_page.dart';
import 'package:clothing_waste_app/tabitems/add_page.dart';
import 'package:flutter/material.dart';

import '../tabitems/homepage.dart';
import '../tabitems/search_page.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  const TabNavigator({Key? key, this.navigatorKey, this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const HomePage();
    switch (tabItem) {
      case "shop":
        child = const ShopPage();
        break;
      case "add":
        child = const AddPage();
        break;
      case "search":
        child = const SearchPage();
        break;
      case "profile":
        child = const ProfilePage();
        break;
      default:
        child = const HomePage();
        break;
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

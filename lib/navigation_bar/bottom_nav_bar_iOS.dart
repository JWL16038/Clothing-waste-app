import 'package:clothing_waste_app/design/colours.dart';
import 'package:clothing_waste_app/side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homepage/homepage.dart';
import '../homepage/search_page.dart';
import '../homepage/shop_page.dart';
import '../homepage/add_page.dart';
import '../userprofile/profile_page.dart';

//
// final GlobalKey<NavigatorState> featuredNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> shopNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> addNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> searchNavKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> profileNavKey = GlobalKey<NavigatorState>();

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        switch (index) {
          case 1:
            return CupertinoTabView(
              builder: (context) => const ShopPage(),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => const AddPage(),
            );
          case 3:
            return CupertinoTabView(
              builder: (context) => const SearchPage(),
            );
          case 4:
            return CupertinoTabView(
              builder: (context) => const ProfilePage(),
            );
          default:
            return CupertinoTabView(
              builder: (context) => const HomePage(),
            );
        }
      },
      tabBar: CupertinoTabBar(
        inactiveColor: secondaryColor,
        activeColor: primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.featured_play_list_outlined,
            ),
            label: 'Featured Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop_2_outlined,
            ),
            label: 'Shop items',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            label: 'Add item',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

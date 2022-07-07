import 'package:clothing_waste_app/design/colours.dart';
import 'package:clothing_waste_app/ui/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homepage/homepage.dart';
import '../homepage/search_page.dart';
import '../homepage/shop_page.dart';
import '../items/add_page.dart';
import '../userprofile/profile_page.dart';

int _selectedIndex = 0;
String _currentPage = "home";
List<String> pageKeys = ["home", "shop", "add", "search", "profile"];

final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
  "home": GlobalKey<NavigatorState>(),
  "shop": GlobalKey<NavigatorState>(),
  "add": GlobalKey<NavigatorState>(),
  "search": GlobalKey<NavigatorState>(),
  "profile": GlobalKey<NavigatorState>(),
};

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _selectTab(String tabItem, int index) {
    setState(
          () {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      },
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        //return !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        return true;
      },
      child: CupertinoTabScaffold(

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
                Icons.home,
              ),
              label: 'Home',
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
      ),
    );
  }
}

import 'package:clothing_waste_app/design/colours.dart';
import 'package:clothing_waste_app/ui/side_bar.dart';
import 'package:clothing_waste_app/ui/tab_navigator.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'global_keys.dart';

int _selectedIndex = 0;
String _currentPage = pageKeys[_selectedIndex];

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  void _selectTab(String tabItem, int index) {
    if (mounted) {
      setState(
        () {
          _currentPage = pageKeys[index];
          _selectedIndex = index;
        },
      );
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKeys[_currentPage]!.currentState!.maybePop();
      },
      child: Scaffold(
        appBar: const AppBar_app(),
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(pageKeys[0]),
            _buildOffstageNavigator(pageKeys[1]),
            _buildOffstageNavigator(pageKeys[2]),
            _buildOffstageNavigator(pageKeys[3]),
            _buildOffstageNavigator(pageKeys[4]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: const IconThemeData(color: primaryColor, size: 30),
          selectedItemColor: primaryColor,
          unselectedIconTheme:
              const IconThemeData(color: secondaryColor, size: 30),
          unselectedItemColor: secondaryColor,
          iconSize: 48.0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: pageKeys[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.shop_2_outlined,
              ),
              label: pageKeys[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.add_circle_outline,
              ),
              label: pageKeys[2],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.search_outlined,
              ),
              label: pageKeys[3],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.account_circle_outlined,
              ),
              label: pageKeys[4],
            ),
          ],
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
        ),
        drawer: const SideBar(),
      ),
    );
  }
}

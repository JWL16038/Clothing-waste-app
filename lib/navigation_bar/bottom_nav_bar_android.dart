import 'package:clothing_waste_app/design/colours.dart';
import 'package:clothing_waste_app/messaging/messaging_main.dart';
import 'package:clothing_waste_app/side_bar.dart';
import 'package:clothing_waste_app/navigation_bar/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 0;
String _currentPage = "Page1";
List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
  "Page1": GlobalKey<NavigatorState>(),
  "Page2": GlobalKey<NavigatorState>(),
  "Page3": GlobalKey<NavigatorState>(),
  "Page4": GlobalKey<NavigatorState>(),
  "Page5": GlobalKey<NavigatorState>(),
};

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Route gotoMessaging() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MessagingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  void _selectTab(String tabItem, int index) {
    setState(
      () {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Title bar"),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.message_outlined),
        //       onPressed: () {
        //         Navigator.of(context).push(gotoMessaging());
        //       },
        //     ),
        //   ],
        // ),
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Page1"),
            _buildOffstageNavigator("Page2"),
            _buildOffstageNavigator("Page3"),
            _buildOffstageNavigator("Page4"),
            _buildOffstageNavigator("Page5"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedIconTheme:
              const IconThemeData(color: primaryColor, size: 30),
          selectedItemColor: primaryColor,
          unselectedIconTheme:
              const IconThemeData(color: secondaryColor, size: 30),
          unselectedItemColor: secondaryColor,
          iconSize: 48.0,
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
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
        ),
        //
        //drawer: const SideBar(),
      ),
    );
  }
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

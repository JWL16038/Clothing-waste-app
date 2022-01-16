import 'package:clothing_waste_app/side_bar.dart';
import 'package:clothing_waste_app/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


int _selectedIndex = 0;
String _currentPage = "Page1";
List<String> pageKeys = ["Page1","Page2","Page3","Page4","Page5",];
final Map<String,GlobalKey<NavigatorState>> _navigatorKeys = {
  "Page1":GlobalKey<NavigatorState>(),
  "Page2":GlobalKey<NavigatorState>(),
  "Page3":GlobalKey<NavigatorState>(),
  "Page4":GlobalKey<NavigatorState>(),
  "Page5":GlobalKey<NavigatorState>(),
};

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  void _selectTab(String tabItem,int index){
    if(tabItem == _currentPage){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }
    else{
      setState((){
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          if(isFirstRouteInCurrentTab){
            if(_currentPage != "Page1"){
              _selectTab("Page1",0);
              return false;
            }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Clothing waste app prototype"),
          actions: const <Widget> [
            IconButton(
                icon: Icon(Icons.message_outlined),
                onPressed: pressed,
             ),
          ]
        ),
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
          selectedIconTheme: const IconThemeData(color: Colors.deepOrangeAccent,size: 30),
          selectedItemColor: Colors.deepOrangeAccent,
          unselectedIconTheme: const IconThemeData(color: Colors.blueAccent,size: 30),
          unselectedItemColor: Colors.blueAccent,
          iconSize: 48.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined),
              label: 'Featured Items',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two_outlined),
              label: 'Buy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_3_outlined),
              label: 'Sell',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_vert),
              label: 'Swap',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          onTap: (int index){
            _selectTab(pageKeys[index],index);
          },
          currentIndex: _selectedIndex,
        ),
        drawer: const SideBar(),
      ),
    );
  }
}

Widget _buildOffstageNavigator(String tabItem){
  return Offstage(
    offstage: _currentPage != tabItem,
    child: TabNavigator(
      navigatorKey: _navigatorKeys[tabItem],
      tabItem: tabItem,
    )
  );
}


void pressed() {

}

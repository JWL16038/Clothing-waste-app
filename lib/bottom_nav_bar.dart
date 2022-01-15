import 'package:clothing_waste_app/homepage.dart';
import 'package:clothing_waste_app/profile_page.dart';
import 'package:clothing_waste_app/sell_page.dart';
import 'package:clothing_waste_app/buy_page.dart';
import 'package:clothing_waste_app/side_bar.dart';
import 'package:clothing_waste_app/swap_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Products/featured_page.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;



  void _selectPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clothing waste app prototype"),
        actions: const <Widget> [
          IconButton(
              icon: Icon(Icons.message_outlined),
              onPressed: pressed,
           ),
        ]
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const[
          HomePage(),
          BuyPage(),
          SellPage(),
          SwapPage(),
          ProfilePage(),
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
        onTap: _selectPage,
        currentIndex: _selectedIndex,
      ),
      drawer: const SideBar(),
    );
  }
}

void pressed(){

}

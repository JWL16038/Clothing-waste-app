import 'package:clothing_waste_app/homepage/buy_page.dart';
import 'package:clothing_waste_app/userprofile/profile_page.dart';
import 'package:clothing_waste_app/homepage/shop_page.dart';
import 'package:clothing_waste_app/homepage/add_page.dart';
import 'package:flutter/material.dart';

import '../homepage/homepage.dart';
import '../side_bar.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;


  const TabNavigator({Key? key, this.navigatorKey,this.tabItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const HomePage();

    if(tabItem == "Page1"){
      child = const HomePage();
    }
    else if(tabItem == "Page2"){
      child = const BuyPage();
    }
    else if(tabItem == "Page3"){
      child = const ShopPage();
    }
    else if(tabItem == "Page4"){
      child = const AddPage();
    }
    else if(tabItem == "Page5"){
      child = const ProfilePage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

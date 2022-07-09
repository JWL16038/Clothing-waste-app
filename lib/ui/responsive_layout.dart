import 'dart:io';

import 'package:clothing_waste_app/providers/user_provider.dart';
import 'package:clothing_waste_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar_android.dart' as android;
import 'bottom_nav_bar_ios.dart' as ios;

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState(){
    super.initState();
    initializeUserData();
  }

  void initializeUserData() async{
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints) {
      if(Platform.isAndroid){
        return const android.BottomNavBar();
      }
      else if(Platform.isIOS){
        return const ios.BottomNavBar();
      }
      showSnackBar("Platform not recognized yet, default to android.",context);
      return const android.BottomNavBar();
    });
  }
}

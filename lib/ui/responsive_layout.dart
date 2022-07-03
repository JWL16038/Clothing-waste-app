import 'dart:io';

import 'package:flutter/material.dart';

import 'bottom_nav_bar_android.dart' as android;
import 'bottom_nav_bar_ios.dart' as ios;

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints) {
      if(Platform.isAndroid){
        return const android.BottomNavBar();
      }
      else if(Platform.isIOS){
        return const ios.BottomNavBar();
      }
      print("Platform not recognized yet. Default to android.");
      return const android.BottomNavBar();
    });
  }
}

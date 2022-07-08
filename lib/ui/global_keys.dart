import 'package:flutter/material.dart';

List<String> pageKeys = ["home", "shop", "add", "search", "profile"];

final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
  pageKeys[0]: GlobalKey<NavigatorState>(),
  pageKeys[1]: GlobalKey<NavigatorState>(),
  pageKeys[2]: GlobalKey<NavigatorState>(),
  pageKeys[3]: GlobalKey<NavigatorState>(),
  pageKeys[4]: GlobalKey<NavigatorState>(),
};
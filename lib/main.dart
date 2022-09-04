import 'dart:io' show Platform;

import 'package:clothing_waste_app/authentication/login_page.dart';
import 'package:clothing_waste_app/providers/user_provider.dart';
import 'package:clothing_waste_app/ui/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clothing_waste_app/authentication/authentication_methods.dart';

/**
 *
 */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //AuthMethods().logout();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clothing waste app prototype',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // home: LoginPage(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Text('Something went wrong: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return const ResponsiveLayout();
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}

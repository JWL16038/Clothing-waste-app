import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'navigation_bar/bottom_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing waste app prototype',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future:_fbApp,
        builder: (context,snapshot){
          if(snapshot.hasError){
            print(snapshot.error.toString());
            return const Text('Something went wrong!');
          }
          else if(snapshot.hasData){
            return const BottomNavBar();
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}

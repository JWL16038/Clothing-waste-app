import 'package:clothing_waste_app/utils/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
import 'dart:typed_data';

import 'package:clothing_waste_app/firebase/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/user_model.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signup({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String msg = "";

    try {
      if (firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          userName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoURL =
            await StorageMethods().uploadImageToStorage('profilePics', file);

        model.User user = model.User(
          uid: cred.user!.uid,
          firstname: firstName,
          lastname: lastName,
          username: userName,
          email: email,
          photoUrl: photoURL,
          bio: "",
          items: [],
          feedback: [],
          watchers: [],
          watching: [],
        );

        _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        msg = "Success";
      } else {
        msg = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          msg = "Account with this already exists";
          break;
        case 'operation-not-allowed':
          msg = "Operation not allowed";
          break;
        case 'weak-password':
          msg = "Password must be at least 6 characters long";
          break;
        case 'invalid-email':
          msg = "Invalid email";
          break;
        default:
          msg = error.toString();
      }
    }

    return msg;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String msg = "";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        msg = "Success";
      } else {
        msg = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          msg = "User doesn't exist";
          break;
        case 'user-disabled':
          msg = "Account has been disabled";
          break;
        case 'wrong-password':
          msg = "Password is incorrect";
          break;
        case 'invalid-email':
          msg = "Invalid email";
          break;
        default:
          msg = error.toString();
      }
    }

    return msg;
  }
}

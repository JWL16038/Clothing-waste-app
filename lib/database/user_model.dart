import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String photoUrl;
  final String bio;
  final List items;
  final List feedback;
  final List watchers;
  final List watching;

  const User({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.bio,
    required this.items,
    required this.feedback,
    required this.watchers,
    required this.watching,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "items": items,
        "feedback": feedback,
        "watchers": watchers,
        "watching": watching,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      username: snapshot['username'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      items: snapshot['items'],
      feedback: snapshot['feedback'],
      watchers: snapshot['watchers'],
      watching: snapshot['watching'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  // final String itemID;
  final String caption;
  final String itemName;
  final String itemDesc;
  final int price;
  final String photoUrl;
  final String colour;
  final String condition;
  final int size;
  final String adddate;

  const Item({
    // required this.itemID,
    required this.caption,
    required this.itemName,
    required this.itemDesc,
    required this.price,
    required this.photoUrl,
    required this.colour,
    required this.condition,
    required this.size,
    required this.adddate,
  });

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "itemName": itemName,
        "itemDesc": itemDesc,
        "price": price,
        "photoUrl": photoUrl,
        "colour": colour,
        "condition": condition,
        "size": size,
        "adddate": adddate,
      };

  static Item fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Item(
      caption: snapshot['caption'],
      itemName: snapshot['itemName'],
      itemDesc: snapshot['itemDesc'],
      price: snapshot['price'],
      colour: snapshot['colour'],
      condition: snapshot['condition'],
      size: snapshot['size'],
      photoUrl: snapshot['photoUrl'],
      adddate: snapshot['adddate'],
    );
  }
}

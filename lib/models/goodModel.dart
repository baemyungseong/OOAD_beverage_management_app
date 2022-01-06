import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Good {
  final String id;
  final String name;
  final String quantity;
  final String image;

  Good({
    required this.id,
    required this.name,
    required this.quantity,
    required this.image,
  });

  factory Good.fromDocument(Map<String, dynamic> doc) {
    return Good(
      id: doc['id'],
      name: doc['name'],
      quantity: doc['quantity'],
      image: doc["image"],
    );
  }
}

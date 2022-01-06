import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Drink {
  final String id;
  final String name;
  final String description;
  final String category;
  final String quantity;
  final String image;
  final String price;

  Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.image,
    required this.price,
  });

  factory Drink.fromDocument(Map<String, dynamic> doc) {
    return Drink(
      id: doc['id'],
      name: doc['name'],
      category: doc['category'],
      description: doc['description'],
      quantity: doc['quantity'],
      image: doc["image"],
      price: doc['price'],
    );
  }
}

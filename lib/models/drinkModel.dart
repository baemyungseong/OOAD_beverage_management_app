import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Drink {
  final String id;
  final String name;
  final String description;
  final String category;
  final String image;
  final String unit_price;
  final DateTime timestamp;

  Drink({
    this.id = "",
    this.name = "",
    this.description = "",
    this.category = "",
    this.image = "",
    this.unit_price = "",
    DateTime? timestamp,
  }) : this.timestamp = timestamp ?? DateTime.now();

  factory Drink.fromDocument(DocumentSnapshot doc) {
    return Drink(
      id: doc['id'],
      name: doc['name'],
      category: doc['category'],
      description: doc['description'],
      image: doc["image"],
      unit_price: doc['unit price'],
      timestamp: DateFormat("dd/MM/yyyy HH:mm:ss").parse(doc['timestamp']),
    );
  }
}

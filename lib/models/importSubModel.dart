import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ImportSub {
  final String id;
  final String idGood;
  final String idImport;
  final String quantity;
  final String unit;
  final String name;

  ImportSub({
    required this.id,
    required this.idGood,
    required this.idImport,
    required this.quantity,
    required this.unit,
    required this.name,
  });

  factory ImportSub.fromDocument(Map<String, dynamic> doc) {
    return ImportSub(
      id: doc['id'],
      idGood: doc['idGood'],
      idImport: doc['idImport'],
      quantity: doc['quantity'],
      name: doc['name'],
      unit: doc['unit'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Trouble {
  final String id;
  final String name;
  final String category;
  final String money;
  final String idIncidentReport;

  Trouble({
    required this.id,
    required this.name,
    required this.category,
    required this.money,
    required this.idIncidentReport,
  });

  factory Trouble.fromDocument(Map<String, dynamic> doc) {
    return Trouble(
      id: doc['id'],
      name: doc['name'],
      category: doc['category'],
      money: doc['money'],
      idIncidentReport: doc['idIncidentReport'],
    );
  }
}

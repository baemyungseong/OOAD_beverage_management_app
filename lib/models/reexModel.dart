import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Reex {
  final String id;
  final String type;
  final String itemId;
  final String money;
  final DateTime timestamp;

  Reex({
    this.id = "",
    this.type = "",
    this.itemId = "",
    this.money = "",
    DateTime? timestamp,
    }) : this.timestamp = timestamp ?? DateTime.now();

  factory Reex.fromDocument(DocumentSnapshot doc) {
    return Reex(
      id: doc.id,
      type: doc['type'],
      itemId: doc['itemId'],      
      money: doc['money'],
      timestamp: DateFormat("dd/MM/yyyy HH:mm:ss").parse(doc['timestamp']),
    );
  }
}
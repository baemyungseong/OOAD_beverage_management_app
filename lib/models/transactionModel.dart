import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Trans {
  final String id;
  final String code;
  final String type;
  final String itemId;
  final String money;
  final DateTime timestamp;

  Trans({
    this.id = "",
    this.code = "",
    this.type = "",
    this.itemId = "",
    this.money = "",
    DateTime? timestamp,
    }) : this.timestamp = timestamp ?? DateTime.now();

  factory Trans.fromDocument(DocumentSnapshot doc) {
    return Trans(
      id: doc.id,
      code: doc['code'],
      type: doc['type'],
      itemId: doc['itemId'],      
      money: doc['money'],
      timestamp: DateFormat("dd/MM/yyyy HH:mm:ss").parse(doc['timestamp']),
    );
  }
}
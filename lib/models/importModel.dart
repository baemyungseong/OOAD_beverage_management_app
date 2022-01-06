import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Import {
  final String id;
  final String sender;
  final String receiver;
  final String description;
  final String note;
  final List goodsDetail;
  final String total;
  final String time;
  final String status;

  Import({
    required this.id,
    required this.sender,
    required this.description,
    required this.receiver,
    required this.note,
    required this.goodsDetail,
    required this.total,
    required this.time,
    required this.status,
  });

  factory Import.fromDocument(Map<String, dynamic> doc) {
    return Import(
        id: doc['id'],
        sender: doc['sender'],
        receiver: doc['receiver'],
        description: doc['description'],
        note: doc['note'],
        goodsDetail: doc["goodsDetail"],
        total: doc['total'],
        status: doc['status'],
        time: doc['time']);
  }
}

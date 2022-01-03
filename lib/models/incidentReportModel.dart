import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class IncidentReport {
  final String id;
  final String name;
  final String status;
  final String reason;
  final List performer;
  final String time;
  final List trouble;
  final String partyinTrouble;
  final String total;

  IncidentReport({
    required this.id,
    required this.name,
    required this.status,
    required this.reason,
    required this.performer,
    required this.time,
    required this.trouble,
    required this.partyinTrouble,
    required this.total,
  });

  factory IncidentReport.fromDocument(Map<String, dynamic> doc) {
    return IncidentReport(
        id: doc['id'],
        name: doc['name'],
        trouble: doc['detailOfTrouble'],
        performer: doc['performer'],
        reason: doc["reason"],
        partyinTrouble: doc["partyInTrouble"],
        status: doc['status'],
        time: doc['time'],
        total: doc['total']);
  }
}

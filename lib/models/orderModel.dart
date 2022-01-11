import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ui_fresh_app/models/orderDetailModel.dart';

class Order {
  final String id;
  final String serveId;
  final String code;
  List<String> staffs = [];
  List<OrderDetail> orderDetails = [];
  final String totalMoney;
  final String isCheckedOutByAccountant;
  final String isCheckedOutByBartender;
  final String isCheckedOutByServe;
  final String isConfirmedPurchased;
  final DateTime timestamp;

  Order({
    this.id = "",
    this.serveId = "",
    this.code = "",
    this.totalMoney = "",
    this.isCheckedOutByAccountant = "",
    this.isCheckedOutByBartender = "",
    this.isCheckedOutByServe = "",
    this.isConfirmedPurchased = "",
    DateTime? timestamp,
  }) : this.timestamp = timestamp ?? DateTime.now();

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order(
      id: doc.id,
      serveId: doc['serveId'],
      code: doc['code'],
      totalMoney: doc['total money'],
      isCheckedOutByAccountant: doc['isCheckedOutByAccountant'],
      isCheckedOutByBartender: doc['isCheckedOutByBartender'],
      isCheckedOutByServe: doc['isCheckedOutByServe'],
      isConfirmedPurchased: doc['isConfirmedPurchased'],
      timestamp: DateFormat("dd/MM/yyyy HH:mm:ss").parse(doc['timestamp']),
    );
  }
}
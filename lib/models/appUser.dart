import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class appUser {
  final String id;
  final String email;
  final String name;
  final String phone_number;
  final String dob;
  final String avatar;
  final String role;
  final DateTime timestamp;
  final String encoded_pw; 
  final String key;

  appUser({
    this.id = "",
    this.email = "",
    this.name = "",
    this.phone_number= "",
    this.dob = "",
    this.avatar = "",
    this.role = "",
    DateTime? timestamp,
    this.encoded_pw = "",
    this.key = "", 
    }) : this.timestamp = timestamp ?? DateTime.now();

  factory appUser.fromDocument(DocumentSnapshot doc) {
    return appUser(
      id: doc.id,
      email: doc['email'],
      name: doc['name'],
      phone_number: doc['phone number'],
      dob: doc['dob'],
      avatar: doc['avatar'],
      role: doc['role'],
      timestamp: DateFormat("dd/MM/yyyy HH:mm:ss").parse(doc['timestamp']),
      encoded_pw: doc['encoded_pw'],
      key: doc['key'],
    );
  }
}
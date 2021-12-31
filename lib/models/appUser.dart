import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class appUser {
  final String id;
  final String email;
  final String name;
  final String phone_number;
  final String dob;
  final String avatar;
  final String role;

  appUser({
    this.id = "",
    this.email = "",
    this.name = "",
    this.phone_number= "",
    this.dob = "",
    this.avatar = "",
    this.role = "",
  });

  factory appUser.fromDocument(DocumentSnapshot doc) {
    return appUser(
      id: doc.id,
      email: doc['email'],
      name: doc['name'],
      phone_number: doc['phone number'],
      dob: doc['dob'],
      avatar: doc['avatar'],
      role: doc['role'],
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:ui_fresh_app/models/appUser.dart';

final userReference = FirebaseFirestore.instance.collection("users");
final drinksReference = FirebaseFirestore.instance.collection("drinks");
final cartsReference = FirebaseFirestore.instance.collection("carts");
final ordersReference = FirebaseFirestore.instance.collection("orders");
final transReference = FirebaseFirestore.instance.collection("transactions");
final reexReference = FirebaseFirestore.instance.collection("reex");

final firebase_storage.Reference avatarsReference = firebase_storage.FirebaseStorage.instance.ref().child("random_avatars");
final firebase_storage.Reference _drinksReference = firebase_storage.FirebaseStorage.instance.ref().child("drink_categories");
final firebase_storage.Reference teasReference = _drinksReference.child("tea");
final firebase_storage.Reference juicesReference = _drinksReference.child("juice");
final firebase_storage.Reference beersReference = _drinksReference.child("beer");
final firebase_storage.Reference winesReference = _drinksReference.child("wine");

appUser currentUser = appUser();

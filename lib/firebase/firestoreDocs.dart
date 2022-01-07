import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:ui_fresh_app/models/appUser.dart';

final userReference = FirebaseFirestore.instance.collection("users");

final firebase_storage.Reference avatarsReference = firebase_storage.FirebaseStorage.instance.ref().child("random_avatars");
final firebase_storage.Reference drinksReference = firebase_storage.FirebaseStorage.instance.ref().child("drink_categories");
final firebase_storage.Reference teasReference = drinksReference.child("tea");
final firebase_storage.Reference juicesReference = drinksReference.child("juice");
final firebase_storage.Reference beersReference = drinksReference.child("beer");
final firebase_storage.Reference winesReference = drinksReference.child("wine");

appUser currentUser = appUser();

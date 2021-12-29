import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ui_fresh_app/models/appUser.dart';

final userReference = FirebaseFirestore.instance.collection("users");

appUser currentUser = appUser();
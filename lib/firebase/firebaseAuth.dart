import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

class firebaseAuth {
  //Sign-up
  signUp(String email, String password, context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.', 'error');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.', 'error');
      }
    } 
  }

  //Sign-in
  signIn(String email, String password, context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  //Reset password
  resetPassword(String email) {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Sign-out
  signOut() async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }
}

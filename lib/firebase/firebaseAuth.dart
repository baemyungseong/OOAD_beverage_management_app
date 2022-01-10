import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:ui_fresh_app/views/authentication/checkinEmail.dart';
import 'package:ui_fresh_app/views/navigationBar/atNavigationBar.dart';
import 'package:ui_fresh_app/views/navigationBar/btNavigationBar.dart';
import 'package:ui_fresh_app/views/navigationBar/skNavigationBar.dart';
import 'package:ui_fresh_app/views/navigationBar/svNavigationBar.dart';

import 'package:ui_fresh_app/models/appUser.dart';
//import widgets
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:path/path.dart';

class firebaseAuth {
  //Sign-up
  signUp(String email, String password, context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.', 'error');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
            context, 'The account already exists for that email.', 'error');
      }
    }
  }

  //Sign-in
  signIn(String email, String password, context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    // return _firebaseAuth.signInWithEmailAndPassword(
    //     email: email, password: password);
    PlatformStringCryptor cryptor;
    cryptor = PlatformStringCryptor();
    final salt = await cryptor.generateSalt();

    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        var key = await cryptor.generateKeyFromPassword(password, salt);
        var encrypted = await cryptor.encrypt(password, key);
        final FirebaseAuth auth = FirebaseAuth.instance;
        final User? user = auth.currentUser;
        final uid = user?.uid;
        //Update new decoded_pw and new key
        userReference.doc(uid).update({
          "encoded_pw": encrypted,
          "key": key,
        });
        print("successfully login!");
        // final User? user = _firebaseAuth.currentUser;
        // final uid = user?.uid;
        DocumentSnapshot documentSnapshot = await userReference.doc(uid).get();
        currentUser = appUser.fromDocument(documentSnapshot);
        print("Your current id is $uid");
        if (uid != null) {
          if (currentUser.role == "storekeeper")
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => storekeeperNavigationBar()),
                (Route<dynamic> route) => route is storekeeperNavigationBar);
          else if (currentUser.role == "serve")
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => serveNavigationBar()),
                (Route<dynamic> route) => route is serveNavigationBar);
          else if (currentUser.role == "bartender")
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => bartenderNavigationBar()),
                (Route<dynamic> route) => route is bartenderNavigationBar);
          else if (currentUser.role == "accountant")
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => accountantNavigationBar()),
                (Route<dynamic> route) => route is accountantNavigationBar);
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "user-not-found":
          showSnackBar(
              context, "Your email is not found, please check!", 'error');
          break;
        case "wrong-password":
          showSnackBar(
              context, "Your password is wrong, please check!", 'error');
          break;
        case "invalid-email":
          showSnackBar(
              context, "Your email is invalid, please check!", 'error');
          break;
        case "user-disabled":
          showSnackBar(context, "The user account has been disabled!", 'error');
          break;
        case "too-many-requests":
          showSnackBar(
              context, "There was too many attempts to sign in!", 'error');
          break;
        case "operation-not-allowed":
          showSnackBar(context, "The user account are not enabled!", 'error');
          break;
        // // Preventing user from entering email already provided by other login method
        // case "account-exists-with-different-credential":
        //   showErrorSnackBar(context, "This account exists with a different sign in provider!");
        //   break;

        default:
          showSnackBar(context, "An undefined Error happened.", 'error');
      }
    }
  }

  //Reset password
  resetPassword(String email, context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    // _firebaseAuth.sendPasswordResetEmail(email: email);
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) => {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => checkinEmailScreen(),
            //   ),
            // )
          });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          showSnackBar(
              context, "Your email is invalid, please check!", 'error');
          break;
        case "user-not-found":
          showSnackBar(
              context, "Your email is not found, please check!", 'error');
          break;

        default:
          showSnackBar(context, "An undefined Error happened.", 'error');
      }
    }
  }

  //Sign-out
  signOut() async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }

  //changePassword
  static Future<void> changePassword(
      currentPassword, newPassword, context) async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      try {
        var authResult = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: (user.email).toString(),
            password: currentPassword,
          ),
        );
        user.updatePassword(newPassword).then((_) {
          controlUpdateEncPw(newPassword);
          showSnackBar(context, 'Successfully changed password!', 'success');
          Navigator.pop(context);
        }).catchError((error) {
          showSnackBar(context, 'Your current password is wrong!', 'error');
        });
        return null;
      } on FirebaseAuthException {
        showSnackBar(context, 'Your current password is wrong!', 'error');
      }
    } on FirebaseAuthException {
      showSnackBar(context, 'Your current password is wrong!', 'error');
    }
  }
}

controlUpdateEncPw(_newPw) async {
  //Update encoded_pw
  PlatformStringCryptor cryptor;
  cryptor = PlatformStringCryptor();
  final salt = await cryptor.generateSalt();
  var key = await cryptor.generateKeyFromPassword(_newPw, salt);
  var new_encoded_pw = await cryptor.encrypt(_newPw, key);

  userReference.doc(currentUser.id).update({
    "encoded_pw": new_encoded_pw,
    "key": key,
  });
}

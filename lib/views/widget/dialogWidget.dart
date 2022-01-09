import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:ui_fresh_app/models/appUser.dart';
import 'package:ui_fresh_app/models/drinkModel.dart';
import 'package:ui_fresh_app/views/account/accountMessageDetail.dart';
import 'package:ui_fresh_app/views/account/profileManagement.dart';

//import views
import 'package:ui_fresh_app/views/authentication/signIn.dart';

//import others
import 'package:iconsax/iconsax.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';

datePickerDialog(BuildContext context, selectDate, category) {
  return showRoundedDatePicker(
      // customWeekDays: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
      height: 320,
      context: context,
      fontFamily: "SFProText",
      theme: ThemeData(primarySwatch: Colors.blue),
      // listDateDisabled: [
      //   DateTime.now().add(Duration(days: 1)),
      //   DateTime.now().add(Duration(days: 4)),
      //   DateTime.now().add(Duration(days: 6)),
      //   DateTime.now().add(Duration(days: 8)),
      //   DateTime.now().add(Duration(days: 10)),
      // ],
      initialDate: selectDate,
      // initialDate: DateTime(2022, 12, 17),
      firstDate: DateTime(1900),
      lastDate: (category == "reex" || category == "dob")
          ? DateTime.now()
          : DateTime(2050),
      // onTapActionButton:() {
      //   if()
      // },

      styleDatePicker: MaterialRoundedDatePickerStyle(
        //Section 1
        paddingDateYearHeader: EdgeInsets.all(8),
        backgroundHeader: blueWater,
        textStyleDayButton: TextStyle(
            fontFamily: "SFProText",
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.w500,
            height: 1.0),
        textStyleYearButton: TextStyle(
          fontFamily: "SFProText",
          fontSize: 24,
          color: white,
          fontWeight: FontWeight.w500,
        ),

        //Section 2
        textStyleMonthYearHeader: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        backgroundHeaderMonth: Colors.blue[600],
        paddingMonthHeader: EdgeInsets.only(top: 12, bottom: 12),
        sizeArrow: 24,
        colorArrowNext: white,
        colorArrowPrevious: white,
        // marginLeftArrowPrevious: 8,
        // marginTopArrowPrevious: 0,
        // marginTopArrowNext: 0,
        // marginRightArrowNext: 8,

        //Section 3
        paddingDatePicker: EdgeInsets.all(0),
        backgroundPicker: Colors.blue[200],
        textStyleDayHeader: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        textStyleDayOnCalendar: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w400,
        ),
        textStyleDayOnCalendarSelected: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),

        decorationDateSelected: BoxDecoration(
          color: blueWater,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.10),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),

        textStyleDayOnCalendarDisabled:
            TextStyle(fontSize: 20, color: white.withOpacity(0.1)),

        textStyleCurrentDayOnCalendar: TextStyle(
          fontFamily: "SFProText",
          fontSize: 20,
          color: blueWater,
          fontWeight: FontWeight.w700,
        ),

        //Section 4
        paddingActionBar: EdgeInsets.all(0),
        backgroundActionBar: Colors.blue[300],
        textStyleButtonAction: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        textStyleButtonPositive: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        textStyleButtonNegative: TextStyle(
          fontFamily: "SFProText",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
      ),
      styleYearPicker: MaterialRoundedYearPickerStyle(
        textStyleYear: TextStyle(
            fontFamily: "SFProText",
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textStyleYearSelected: TextStyle(
            fontFamily: "SFProText",
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.w600),
        heightYearRow: 80,
        backgroundPicker: Colors.blue[200],
      ));
}

logoutDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 194,
          width: 299,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            blueWater,
                            Color(0xFF979DFA),
                          ],
                          stops: [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: Icon(
                      Iconsax.logout,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    child: Text(
                      'Do you want to logout \nFresh App?',
                      style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 20,
                        color: blackLight,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      firebaseAuth().signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => signInScreen()),
                          (Route<dynamic> route) => false);
                      showSnackBar(
                          context, "Your account is logged out!", 'success');
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              blueWater,
                              Color(0xFF979DFA),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

//add trouble dialog
int selected = 0;
Widget customRadio(String role, int index, StateSetter setState) {
  return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = index;
            category = role;
          });
        },
        child: AnimatedContainer(
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                fontFamily: "SFProText",
                fontSize: 12.0,
                color: blackLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          height: 36,
          width: 122,
          decoration: BoxDecoration(
            color: (selected == index) ? blueLight : null,
            border: Border(
              top: BorderSide(width: 2, color: blueLight),
              left: BorderSide(width: 2, color: blueLight),
              right: BorderSide(width: 2, color: blueLight),
              bottom: BorderSide(width: 2, color: blueLight),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ));
}

//addTroubleDialog
String name = '';
String category = '';
String money = '';
bool isStatusValid = false;
// String idTrouble = '';
Future addTroubleDialog(BuildContext context, String idTrouble) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Stack(
              children: <Widget>[
                Form(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 16, bottom: 16, left: 24, right: 24),
                    width: 299,
                    height: 429,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF5FAAEF),
                                  Color(0xFF979DFA),
                                ],
                                stops: [
                                  0.0,
                                  1.0,
                                ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: Icon(
                            Iconsax.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Create new trouble',
                          style: TextStyle(
                            fontSize: content20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Trouble\'\s Name',
                          style: TextStyle(
                            fontSize: content14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 251,
                          height: 36,
                          child: TextFormField(
                            onChanged: (value) {
                              name = value;
                            },
                            autofocus: false,
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: content12,
                                fontWeight: FontWeight.w400,
                                color: blackLight,
                                height: 1.4),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 0),
                              hintText: "What're your trouble?",
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content12,
                                  fontWeight: FontWeight.w400,
                                  color: grey8,
                                  height: 1.4),
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: content14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            customRadio('Compensation', 1, setState),
                            SizedBox(
                              width: 7,
                            ),
                            customRadio('Cost', 2, setState),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Money',
                          style: TextStyle(
                            fontSize: content14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 122,
                          height: 36,
                          child: TextFormField(
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: content14,
                                fontWeight: FontWeight.w400,
                                color: blackLight,
                                height: 1.0),
                            onChanged: (value) {
                              money = value;
                            },
                            decoration: InputDecoration(
                              prefix: Column(
                                children: [
                                  Text(
                                    '\$ ',
                                    style: TextStyle(
                                        fontFamily: 'SFProText',
                                        fontSize: content12,
                                        fontWeight: FontWeight.w400,
                                        color: blackLight,
                                        height: 1.4),
                                  ),
                                  SizedBox(height: 0.3)
                                ],
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 0),
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content12,
                                  fontWeight: FontWeight.w400,
                                  color: grey8,
                                  height: 1.6),
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('troubles')
                                    .add({
                                  "name": name,
                                  "category": category,
                                  "money": money,
                                  'idIncidentReport': '',
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection('troubles')
                                      .doc(value.id)
                                      .update({
                                    'id': value.id,
                                  });
                                  print("value.id");
                                  print(value.id);
                                  idTrouble = value.id;
                                  Navigator.of(context).pop(idTrouble);
                                  showSnackBar(
                                      context,
                                      'The trouble have been created!',
                                      'success');
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 122,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        blueWater,
                                        Color(0xFF979DFA),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0,
                                      ]),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Create',
                                    style: TextStyle(
                                      fontFamily: "SFProText",
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 122,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: "SFProText",
                                      fontSize: 16,
                                      color: blackLight,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
}

Future addGoodDialog(BuildContext context, List valueReturn) {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final categoryController = TextEditingController();
  final unitController = TextEditingController();
  bool check = false;
  String idGood = '';
  String idImportSub = '';
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Stack(
              children: <Widget>[
                Form(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 16, bottom: 16, left: 24, right: 24),
                    width: 299,
                    height: 514 - 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF5FAAEF),
                                  Color(0xFF979DFA),
                                ],
                                stops: [
                                  0.0,
                                  1.0,
                                ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: Icon(
                            Iconsax.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Create new goods',
                          style: TextStyle(
                            fontSize: content20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Goods\'\s Name',
                          style: TextStyle(
                            fontSize: content14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 251,
                          height: 36,
                          child: TextFormField(
                            controller: nameController,
                            // initialValue:
                            //     'Tại sao em lại ra đi hả Bùi Khắc Lam',
                            autofocus: false,
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: content12,
                                fontWeight: FontWeight.w400,
                                color: blackLight,
                                height: 1.4),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 0),
                              hintText: "What's the good name?",
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content12,
                                  fontWeight: FontWeight.w400,
                                  color: grey8,
                                  height: 1.4),
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   'Description',
                        //   style: TextStyle(
                        //     fontSize: content14,
                        //     fontWeight: FontWeight.w500,
                        //     fontFamily: 'SFProText',
                        //     color: blackLight,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        // Container(
                        //   width: 251,
                        //   height: 36,
                        //   child: TextFormField(
                        //     controller: descriptionController,
                        //     // initialValue:
                        //     //     'Tại sao em lại ra đi hả Bùi Khắc Lam',
                        //     autofocus: false,
                        //     style: TextStyle(
                        //         fontFamily: 'SFProText',
                        //         fontSize: content12,
                        //         fontWeight: FontWeight.w400,
                        //         color: blackLight,
                        //         height: 1.4),
                        //     decoration: InputDecoration(
                        //       contentPadding:
                        //           EdgeInsets.only(left: 20, right: 0),
                        //       hintText: "What's description?",
                        //       hintStyle: TextStyle(
                        //           fontFamily: 'SFProText',
                        //           fontSize: content12,
                        //           fontWeight: FontWeight.w400,
                        //           color: grey8,
                        //           height: 1.4),
                        //       filled: true,
                        //       fillColor: blueLight,
                        //       border: OutlineInputBorder(
                        //         borderSide: BorderSide.none,
                        //         borderRadius: BorderRadius.circular(8.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 20),
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: content14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 251,
                          height: 36,
                          child: TextFormField(
                            controller: quantityController,
                            // initialValue:
                            //     'Tại sao em lại ra đi hả Bùi Khắc Lam',
                            autofocus: false,
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: content12,
                                fontWeight: FontWeight.w400,
                                color: blackLight,
                                height: 1.4),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 0),
                              hintText: "How many goods are imported?",
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content12,
                                  fontWeight: FontWeight.w400,
                                  color: grey8,
                                  height: 1.4),
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Unit price',
                          style: TextStyle(
                            fontSize: content14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: blackLight,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 122,
                          height: 36,
                          child: TextFormField(
                            controller: unitController,
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: content14,
                                fontWeight: FontWeight.w400,
                                color: blackLight,
                                height: 1.0),
                            decoration: InputDecoration(
                              prefix: Column(
                                children: [
                                  Text(
                                    '\$ ',
                                    style: TextStyle(
                                        fontFamily: 'SFProText',
                                        fontSize: content12,
                                        fontWeight: FontWeight.w400,
                                        color: blackLight,
                                        height: 1.4),
                                  ),
                                  SizedBox(height: 0.3)
                                ],
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 0),
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content12,
                                  fontWeight: FontWeight.w400,
                                  color: grey8,
                                  height: 1.6),
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  valueReturn.add(nameController.text);
                                  valueReturn.add(quantityController.text);
                                  valueReturn.add(unitController.text);
                                  FirebaseFirestore.instance
                                      .collection('importSubs')
                                      .add({
                                    'idGood': '',
                                    'idImport': '',
                                    'quantity': quantityController.text,
                                    'unit': unitController.text,
                                    'name': nameController.text,
                                  }).then((value) => FirebaseFirestore.instance
                                              .collection('importSubs')
                                              .doc(value.id)
                                              .update({
                                            'id': idImportSub = value.id,
                                          }).whenComplete(() {
                                            valueReturn.add(idImportSub);
                                            Navigator.pop(context, valueReturn);
                                          }));
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 122,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        blueWater,
                                        Color(0xFF979DFA),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0,
                                      ]),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Create',
                                    style: TextStyle(
                                      fontFamily: "SFProText",
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 122,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: "SFProText",
                                      fontSize: 16,
                                      color: blackLight,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
}

watchUserDialog(BuildContext context, String _name, String _email,
    String _phone_number, String _dob, String _avatar) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 192,
          width: 303,
          padding: EdgeInsets.only(top: 18, bottom: 18, left: 24, right: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 8),
                      AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 300),
                        child: displayAvatar(_avatar),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: TextStyle(
                            fontSize: content18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFProText',
                            color: blackLight,
                            decoration: TextDecoration.none,
                            height: 1.4),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 0.5,
                        width: 150.0,
                        color: blackLight,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        _email,
                        style: TextStyle(
                            fontSize: content10,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: grey8,
                            decoration: TextDecoration.none,
                            height: 1.4),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _phone_number,
                        style: TextStyle(
                            fontSize: content10,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: grey8,
                            decoration: TextDecoration.none,
                            height: 1.4),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '@' + _dob,
                        style: TextStyle(
                            fontSize: content10,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: grey8,
                            decoration: TextDecoration.none,
                            height: 1.4),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => messageDetailScreen(),
                      //   ),
                      // );
                      // .then((value) {});
                    },
                    child: Container(
                      height: 40,
                      width: 122,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              blueWater,
                              Color(0xFF979DFA),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Message',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

removeIncidentReportDialog(
    BuildContext context, String idIncidentReport, List troubleList) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 194,
          width: 299,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFCB356B),
                            Color(0xFFBD3F32),
                          ],
                          stops: [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: Icon(
                      Iconsax.close_circle,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    child: Text(
                      'Do you want to remove \nthis Incident Report?',
                      style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 20,
                        color: blackLight,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('troubles')
                          .get()
                          .then((value) => value.docs.forEach((element) {
                                if (troubleList
                                    .contains(element.data()['id'] as String)) {
                                  FirebaseFirestore.instance
                                      .collection('troubles')
                                      .doc(element.data()['id'])
                                      .delete();
                                }
                              }))
                          .whenComplete(() => FirebaseFirestore.instance
                              .collection('incidentReports')
                              .doc(idIncidentReport)
                              .delete());
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFCB356B),
                              Color(0xFFBD3F32),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

removeImportDialog(BuildContext context, String idImport, List importSub) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 194,
          width: 299,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFCB356B),
                            Color(0xFFBD3F32),
                          ],
                          stops: [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: Icon(
                      Iconsax.close_circle,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    child: Text(
                      'Do you want to remove \nthis Incident Report?',
                      style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 20,
                        color: blackLight,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("importSubs")
                          .get()
                          .then((value) {
                        value.docs.forEach((element) {
                          if (importSub
                              .contains(element.data()['id'] as String)) {
                            FirebaseFirestore.instance
                                .collection("importSubs")
                                .doc(element.data()['id'] as String)
                                .delete();
                          }
                        });
                      }).whenComplete(() => FirebaseFirestore.instance
                              .collection("imports")
                              .doc(idImport)
                              .delete());
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFCB356B),
                              Color(0xFFBD3F32),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

checkoutImportDialog(BuildContext context, String idImport) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 194,
          width: 299,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF159957),
                            Color(0xFF159199),
                          ],
                          stops: [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: Icon(
                      Iconsax.message_question,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    child: Text(
                      'Do you want to check out \nthis Drink?',
                      style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 20,
                        color: blackLight,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("imports")
                          .doc(idImport)
                          .update({
                        "status": 'Checkout',
                      });
                      Navigator.pop(context);
                      showSnackBar(
                          context, 'The order has been passed!', "success");
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF159957),
                              Color(0xFF159199),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

checkoutDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 194,
          width: 299,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF159957),
                            Color(0xFF159199),
                          ],
                          stops: [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: Icon(
                      Iconsax.message_question,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    child: Text(
                      'Do you want to check out \nthis Drink?',
                      style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 20,
                        color: blackLight,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showSnackBar(
                          context, 'The order has been passed!', "success");
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF159957),
                              Color(0xFF159199),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

List<appUser> userListChoice = [];
TextEditingController searchController = TextEditingController();
Future addPerformerDialog(BuildContext mContext, String id) {
  return showDialog(
      context: mContext,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(28),
            backgroundColor: white,
            content: Container(
              width: 319,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 28, left: 28),
                        alignment: Alignment.center,
                        child: Form(
                          // key: searchFormKey,
                          child: Container(
                            width: 230,
                            height: 36,
                            padding: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: whiteLight),
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                                controller: searchController,
                                onChanged: (val) {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .where("email",
                                          isEqualTo: searchController.text)
                                      .get()
                                      .then((value) {
                                    setState(() {
                                      value.docs.forEach((element) {
                                        var check = userListChoice.where(
                                            (element) =>
                                                element.email ==
                                                searchController.text);
                                        if (check.isEmpty) {
                                          userListChoice.add(
                                              appUser.fromDocument(element));
                                        } else {
                                          showSnackBar(
                                              context,
                                              "This email is searched ",
                                              "error");
                                        }
                                      });
                                    });
                                  });
                                },
                                onEditingComplete: () {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .where("email",
                                          isEqualTo: searchController.text)
                                      .get()
                                      .then((value) {
                                    setState(() {
                                      value.docs.forEach((element) {
                                        var check = userListChoice.where(
                                            (element) =>
                                                element.email ==
                                                searchController.text);
                                        if (check.isEmpty) {
                                          userListChoice.add(
                                              appUser.fromDocument(element));
                                        } else {
                                          showSnackBar(
                                              context,
                                              "This email is searched ",
                                              "error");
                                        }
                                      });
                                    });
                                  });
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                                // controller: searchController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                      child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                        Icon(Iconsax.search_normal_1,
                                            size: 16, color: black)
                                      ])),
                                  border: InputBorder.none,
                                  hintText: "Search by entering email",
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.w400,
                                      height: 1.6),
                                )),
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.only(top: 28),
                        onPressed: () {
                          // Navigator.pop(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         projectManagementScreen(required, uid: uid),
                          //   )
                          // );
                        },
                        icon:
                            Icon(Iconsax.close_square, size: 20, color: black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: 28, right: 28),
                    child: Container(
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: userListChoice.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pop(userListChoice[index].id);
                              showSnackBar(context, 'The user have been added!',
                                  'success');
                              setState(() {
                                searchController.clear();
                                userListChoice.clear();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: blueLight,
                                  borderRadius: BorderRadius.circular(8)),
                              height: 48,
                              width: 319,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 16),
                                        AnimatedContainer(
                                          alignment: Alignment.center,
                                          duration: Duration(milliseconds: 300),
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color: blueWater,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    userListChoice[index]
                                                        .avatar),
                                                fit: BoxFit.cover),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 163,
                                                  child: Text(
                                                    userListChoice[index].name,
                                                    style: TextStyle(
                                                      fontSize: content14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SFProText',
                                                      color: blackLight,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 16,
                                                  width: 44,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    color: blueWater,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      userListChoice[index]
                                                          .role,
                                                      style: TextStyle(
                                                        fontFamily: 'SFProText',
                                                        fontSize: content6,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.sms,
                                                  color: blackLight,
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  userListChoice[index].email,
                                                  style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content8,
                                                    fontWeight: FontWeight.w500,
                                                    color: grey8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.of(context).pop(id);
                  //         showSnackBar(
                  //             context, 'The user have been added!', 'success');
                  //       },
                  //       child: AnimatedContainer(
                  //         duration: Duration(milliseconds: 300),
                  //         width: 122,
                  //         height: 40,
                  //         decoration: BoxDecoration(
                  //           gradient: LinearGradient(
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //               colors: [
                  //                 blueWater,
                  //                 Color(0xFF979DFA),
                  //               ],
                  //               stops: [
                  //                 0.0,
                  //                 1.0,
                  //               ]),
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(8.0),
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: black.withOpacity(0.25),
                  //               spreadRadius: 0,
                  //               blurRadius: 4,
                  //               offset: Offset(0, 4),
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             'Add',
                  //             style: TextStyle(
                  //               fontFamily: "SFProText",
                  //               fontSize: 16,
                  //               color: white,
                  //               fontWeight: FontWeight.w600,
                  //               decoration: TextDecoration.none,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: AnimatedContainer(
                  //         duration: Duration(milliseconds: 300),
                  //         width: 122,
                  //         height: 40,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(8.0),
                  //           ),
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             'Cancel',
                  //             style: TextStyle(
                  //               fontFamily: "SFProText",
                  //               fontSize: 16,
                  //               color: blackLight,
                  //               fontWeight: FontWeight.w600,
                  //               decoration: TextDecoration.none,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 28)
                ],
              ),
            ),
          );
        });
      });
}

searchDialog(
  BuildContext context,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Stack(
              children: <Widget>[
                Form(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 24, bottom: 24, left: 16, right: 16),
                    width: 299,
                    height: 229,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 240,
                              height: 32,
                              child: TextFormField(
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: content14,
                                    fontWeight: FontWeight.w400,
                                    color: blackLight,
                                    height: 1.4),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.search_normal_1,
                                    size: 18,
                                    color: black,
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 0),
                                  hintText: "What're you looking for?",
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8,
                                      height: 1.4),
                                  filled: true,
                                  fillColor: whiteLight,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: Icon(Iconsax.close_square,
                                    size: 19, color: blackLight),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          height: 128,
                          padding: EdgeInsets.only(left: 16, right: 140),
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 4,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         messageDetailScreen(),
                                  //   ),
                                  // );
                                  // .then((value) {});
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: 32,
                                  width: 111,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AnimatedContainer(
                                              alignment: Alignment.center,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                color: blueWater,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        'https://scontent.fsgn5-10.fna.fbcdn.net/v/t1.6435-9/161084499_1011185239289536_7749468629913909457_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=1Z9ynzc2dg4AX_mL5HN&_nc_ht=scontent.fsgn5-10.fna&oh=00_AT92ecLxLZxUsrqM0zA8jcY7hzLCnJ0x_pE78H7gd730uQ&oe=61EC35B8'),
                                                    fit: BoxFit.cover),
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Noob chảo',
                                                  style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content12,
                                                    fontWeight: FontWeight.w600,
                                                    color: blackLight,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  'Accountant',
                                                  style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content8,
                                                    fontWeight: FontWeight.w400,
                                                    color: blackLight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
}

removeDrinkDialog(context, String _drinkID) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 194,
          width: 299,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFCB356B),
                            Color(0xFFBD3F32),
                          ],
                          stops: [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: Icon(
                      Iconsax.close_circle,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    child: Text(
                      'Do you want to remove \nthis Drink?',
                      style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 20,
                        color: blackLight,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var doc = await drinksReference.doc(_drinkID).get();
                      if (doc.exists) {
                        drinksReference.doc(_drinkID).delete();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showSnackBar(context, "The drink has been removed!", 'success');
                      }
                      else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showSnackBar(context, "Failed to remove the drink because it no longer exists.", 'error');
                      }
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFCB356B),
                              Color(0xFFBD3F32),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 122,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 16,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );  

searchMessageDialog(BuildContext context, List<appUser> appUser1) {
  String newMessageId = '';
  String messageId = '';
  List<appUser> userListSearch = [];
  final searchEmailController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Stack(
              children: <Widget>[
                Form(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 24, bottom: 24, left: 16, right: 16),
                    width: 299,
                    height: 229,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 240,
                              height: 32,
                              child: TextFormField(
                                controller: searchEmailController,
                                onChanged: (val) {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .where("email",
                                          isEqualTo: searchEmailController.text)
                                      .get()
                                      .then((value) {
                                    setState(() {
                                      userListSearch.clear();
                                      value.docs.forEach((element) {
                                        var check = userListSearch.where(
                                            (element) =>
                                                element.email ==
                                                searchEmailController.text);
                                        if (check.isEmpty) {
                                          userListSearch.add(
                                              appUser.fromDocument(element));
                                        } else {
                                          showSnackBar(
                                              context,
                                              "This email is searched ",
                                              "error");
                                        }
                                      });
                                    });
                                  });
                                },
                                onEditingComplete: () {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .where("email",
                                          isEqualTo: searchEmailController.text)
                                      .get()
                                      .then((value) {
                                    userListSearch.clear();
                                    setState(() {
                                      value.docs.forEach((element) {
                                        var check = userListSearch.where(
                                            (element) =>
                                                element.email ==
                                                searchEmailController.text);
                                        if (check.isEmpty) {
                                          userListSearch.add(
                                              appUser.fromDocument(element));
                                        } else {
                                          showSnackBar(
                                              context,
                                              "This email is searched ",
                                              "error");
                                        }
                                      });
                                    });
                                  });
                                },
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: content14,
                                    fontWeight: FontWeight.w400,
                                    color: blackLight,
                                    height: 1.4),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.search_normal_1,
                                    size: 18,
                                    color: black,
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 0),
                                  hintText: "What're you looking for?",
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8,
                                      height: 1.4),
                                  filled: true,
                                  fillColor: whiteLight,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: Icon(Iconsax.close_square,
                                    size: 19, color: blackLight),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          height: 128,
                          padding: EdgeInsets.only(left: 16, right: 11),
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: userListSearch.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("messages")
                                      .get()
                                      .then((value) {
                                    value.docs.forEach((element) {
                                      if ((currentUser.id ==
                                                      (element.data()['userId1']
                                                          as String) &&
                                                  userListSearch[index].id ==
                                                      (element.data()['userId2']
                                                          as String)) ||
                                              (currentUser.id ==
                                                      (element.data()['userId2']
                                                          as String) &&
                                                  userListSearch[index].id ==
                                                      (element.data()['userId1']
                                                          as String))
                                          //      &&
                                          // element.data()['timeSend'] != null
                                          ) {
                                        newMessageId = element.id;
                                        print(newMessageId);
                                      }
                                    });
                                    setState(() {
                                      if (newMessageId == '') {
                                        FirebaseFirestore.instance
                                            .collection("messages")
                                            .add({
                                          'userId1': currentUser.id,
                                          'userId2': userListSearch[index].id,
                                          'name1': currentUser.name,
                                          'name2': userListSearch[index].name,
                                          'background1': currentUser.avatar,
                                          'background2':
                                              userListSearch[index].avatar,
                                          'contentList':
                                              FieldValue.arrayUnion([""]),
                                          'lastTimeSend':
                                              "${DateFormat('hh:mm a').format(DateTime.now())}",
                                          'lastMessage': '',
                                        }).then((value) {
                                          setState(() {
                                            FirebaseFirestore.instance
                                                .collection("messages")
                                                .doc(value.id)
                                                .update({
                                              'messageId': value.id,
                                            });
                                          });
                                          messageId = value.id;
                                        });
                                      } else {
                                        (currentUser.id ==
                                                userListSearch[index].id)
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      messageDetailScreen(
                                                          required,
                                                          uid: currentUser.id,
                                                          uid2: userListSearch[
                                                                  index]
                                                              .id,
                                                          messagesId:
                                                              newMessageId),
                                                ),
                                              )
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      messageDetailScreen(
                                                          required,
                                                          uid: userListSearch[
                                                                  index]
                                                              .id,
                                                          uid2: currentUser.id,
                                                          messagesId:
                                                              newMessageId),
                                                ),
                                              );
                                      }
                                    });
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: 32,
                                  width: 200,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AnimatedContainer(
                                              alignment: Alignment.center,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                color: blueWater,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        userListSearch[index]
                                                            .avatar),
                                                    fit: BoxFit.cover),
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    userListSearch[index].name,
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontSize: content12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: blackLight,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  userListSearch[index].role,
                                                  style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content8,
                                                    fontWeight: FontWeight.w400,
                                                    color: blackLight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
}

displayAvatar(String _url) => ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: _url,
        height: 56,
        width: 56,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
      ),
    );

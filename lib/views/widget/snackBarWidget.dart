import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

//import others
import 'package:iconsax/iconsax.dart';

void showSnackBar(context, text, category) {
  final snackBar = SnackBar(
    content: GestureDetector(
      onTap: () => ScaffoldMessenger.of(context)..hideCurrentSnackBar(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 4),
          (category == 'success') ? Icon(Iconsax.verify, size: 24, color: Color(0xFF75CA92)) : ((category == 'error') ? Icon(Iconsax.warning_2, size: 24, color: Color(0xFFDE653F)) : Icon(Iconsax.danger, size: 24, color: Color(0xFFE0B82B))),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: black,
                fontWeight: FontWeight.w600,
                fontSize: content12
              ),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: white,
    duration: Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.symmetric(horizontal: 24),
    behavior: SnackBarBehavior.floating,
    elevation: 10,
  );
  
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
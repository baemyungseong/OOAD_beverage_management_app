import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import others
import 'package:meta/meta.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_line/dotted_line.dart';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';

class svDrinkChosingScreen extends StatefulWidget {
  String drinkID;
  String drinkImageURL;
  String drinkName;
  String drinkDescription;
  String drinkUnitPrice;

  svDrinkChosingScreen(this.drinkID, this.drinkImageURL, this.drinkName, this.drinkDescription, this.drinkUnitPrice,
  { Key? key }) : super(key: key);

  @override
  _svDrinkChosingScreenState createState() => _svDrinkChosingScreenState();
}

class _svDrinkChosingScreenState extends State<svDrinkChosingScreen> {

  String volume = "";
  String condition = "";
  String sugar = "";

  bool haveVolume = false;
  bool haveCondition = false;
  bool haveSugar = false;

  int quantity = 1;
  int totalPrice = 0;

  void initState() {
    super.initState();
    totalPrice = int.parse(widget.drinkUnitPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundDrink), fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                SizedBox(height: 62),
                IconButton(
                  padding: EdgeInsets.only(left: appPadding),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Iconsax.arrow_square_left,
                      size: 32, color: blackLight),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.only(left: appPadding, right: appPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 162,
                            child: Column(
                              children: [
                                SizedBox(height: 45),
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    child: displayDrinkImage(widget.drinkImageURL, 300, 300),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 18),
                          Container(
                            width: 18,
                            height: 136,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: DottedLine(
                                    direction: Axis.vertical,
                                    dashLength: 6.0,
                                    dashColor: grey8,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 16),
                                      (haveVolume == false) ? 
                                      Container(
                                        color: blueLight,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.more_square,
                                            size: 18,
                                            color: blackLight
                                        )
                                      )
                                      : Container(
                                        color: blueLight,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.tick_square,
                                            size: 18,
                                            color: green
                                        )
                                      ),
                                      SizedBox(height: 25),
                                      (haveCondition == false) ? 
                                      Container(
                                        color: blueLight,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.more_square,
                                            size: 18,
                                            color: blackLight
                                        )
                                      )
                                      : Container(
                                        color: blueLight,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.tick_square,
                                            size: 18,
                                            color: green
                                        )
                                      ),
                                      SizedBox(height: 25),
                                      (haveSugar == false) ? 
                                      Container(
                                        color: blueLight,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.more_square,
                                            size: 18,
                                            color: blackLight
                                        )
                                      )
                                      : Container(
                                        color: blueLight,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        child: Icon(Iconsax.tick_square,
                                            size: 18,
                                            color: green
                                        )
                                      ),
                                    ],
                                  ),
                                )
                              ]
                            )
                          ),
                          Spacer(),
                          Container(
                            width: 115,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 17),
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'Volume: $volume',
                                    style: TextStyle(
                                      color: blackLight,
                                      fontSize: content14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SFProText',
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(height: 26),
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'Condition: $condition',
                                    style: TextStyle(
                                      color: blackLight,
                                      fontSize: content14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SFProText',
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(height: 27),
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'Sugar: $sugar',
                                    style: TextStyle(
                                      color: blackLight,
                                      fontSize: content14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SFProText',
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            // width: 319,
                            padding: EdgeInsets.zero,
                            child: Container(
                              width: 240,
                              child: Text(
                                widget.drinkName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: blackLight,
                                  fontSize: title32,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFProText',
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ), 
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(right: 28),
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(quantity > 1) {
                                        quantity--;
                                      }
                                    });
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      Iconsax.minus_square,
                                      size: 24, 
                                      color: blackLight
                                    )
                                  ),
                                )
                              ),
                              Container(
                                width: 48,
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.only(right: 28),
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(quantity < 99) {
                                        quantity++;
                                      }
                                    });
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      Iconsax.add_square,
                                      size: 24, 
                                      color: blackLight
                                    )
                                  ),
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: 319,
                        padding: EdgeInsets.zero,
                        child: Text(
                          widget.drinkDescription,
                          style: TextStyle(
                            color: grey8,
                            fontSize: content14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFProText',
                            height: 1.4
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 28),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Volume:',
                              style: TextStyle(
                                color: blackLight,
                                fontSize: content16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SFProText',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  volume = "500ml";
                                  haveVolume = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: (volume == "500ml") ? blueLight : white,
                                  border: (volume == "500ml") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '500ml',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 12),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  volume = "1000ml";
                                  haveVolume = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: (volume == "1000ml") ? blueLight : white,
                                  border: (volume == "1000ml") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '1000ml',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Condition:',
                              style: TextStyle(
                                color: blackLight,
                                fontSize: content16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SFProText',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  condition = "Cold";
                                  haveCondition = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: (condition == "Cold") ? blueLight : white,
                                  border: (condition == "Cold") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Cold',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 12),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  condition = "Hot";
                                  haveCondition = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: (condition == "Hot") ? blueLight : white,
                                  border: (condition == "Hot") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Hot',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Sugar:',
                              style: TextStyle(
                                color: blackLight,
                                fontSize: content16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SFProText',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sugar = "100%";
                                  haveSugar = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: (sugar == "100%") ? blueLight : white,
                                  border: (sugar == "100%") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '100%',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 8),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sugar = "70%";
                                  haveSugar = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: (sugar == "70%") ? blueLight : white,
                                  border: (sugar == "70%") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '70%',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 8),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sugar = "50%";
                                  haveSugar = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: (sugar == "50%") ? blueLight : white,
                                  border: (sugar == "50%") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '50%',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 8),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sugar = "30%";
                                  haveSugar = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: (sugar == "30%") ? blueLight : white,
                                  border: (sugar == "30%") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '30%',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 8),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sugar = "0%";
                                  haveSugar = true;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 24,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: (sugar == "0%") ? blueLight : white,
                                  border: (sugar == "0%") 
                                  ? Border() 
                                  : Border(
                                    top: BorderSide(width: 1, color: blueLight),
                                    left: BorderSide(width: 1, color: blueLight),
                                    right: BorderSide(width: 1, color: blueLight),
                                    bottom: BorderSide(width: 1, color: blueLight),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '0%',
                                  style: TextStyle(
                                    color: blackLight,
                                    fontSize: content10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFProText',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 36),
                      Row(
                        children: [
                          Container(
                            // width: 319,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '\$' + '${totalPrice * quantity}' + '.0',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: blackLight,
                                fontSize: title36,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SFProText',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            //action navigate to signin screen
                            onTap: () {
                              if (volume != "" && condition != "" && sugar != "") {
                                controlAddDrinkToCart();
                              }
                              else {
                                showSnackBar(context, "Please choose all options for this drink!", "warning");
                              }
                            },
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: Duration(milliseconds: 300),
                              height: 48,
                              width: 160,
                              decoration: BoxDecoration(
                                color: blackLight,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: black.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 64,
                                    offset: Offset(15, 15), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: white,
                                    fontFamily: 'SFProText',
                                    fontWeight: FontWeight.w600,
                                    fontSize: textButton16),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]
                  ),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }

  displayDrinkImage(String _url, double _height, double _width) => ClipRRect(
    child: CachedNetworkImage(
      imageUrl: _url,
      height: _height,
      width: _width,
      placeholder: (context, url) => 
        Center(child: SizedBox(
            child: CircularProgressIndicator(
              color: blackLight,
              strokeWidth: 3,
            ),
            height: 25.0,
            width: 25.0,
          ),
        ),
    ),
  );

  controlAddDrinkToCart() async {
    var doc = await drinksReference.doc(widget.drinkID).get();
    if (doc.exists) {
      cartsReference.doc(currentUser.id).collection("myCart").add({
        "id": "",
        "image": widget.drinkImageURL,
        "name": widget.drinkName,
        "description": widget.drinkDescription,
        "options": "$volume - $condition - $sugar sugar",
        "unit price": widget.drinkUnitPrice,
        "quantity": quantity.toString(),
        "timestamp": DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()),
      }).then(
        (DocumentReference docRef) => docRef.update({"id": docRef.id})
      );
      Navigator.pop(context);
      showSnackBar(context, "The drink has been added to your cart!", 'success');
    }
    else {
      Navigator.pop(context);
      showSnackBar(context, "Failed to add this drink to cart because it no longer exists.", 'error');
    }    
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:ui_fresh_app/views/bartender/dashboard/btCreateDrinkDetail.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/dialogWidget.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import views
import 'package:ui_fresh_app/views/serve/dashboard/svDrinkChosing.dart';

//import others
import 'package:iconsax/iconsax.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';

class btCustomizeDrinkDetailScreen extends StatefulWidget {
  String drinkID;
  String drinkImageURL;
  String drinkName;
  String drinkDescription;
  String drinkUnitPrice;

  btCustomizeDrinkDetailScreen(this.drinkID, this.drinkImageURL, this.drinkName, this.drinkDescription, this.drinkUnitPrice,
  {Key? key}) : super(key: key);

  @override
  _btCustomizeDrinkDetailScreenState createState() =>
      _btCustomizeDrinkDetailScreenState();
}

class _btCustomizeDrinkDetailScreenState
    extends State<btCustomizeDrinkDetailScreen> with InputValidationMixin {

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> priceFormKey = GlobalKey<FormState>();

  int selectVolume = 1;
  int selectCondition = 3;
  int selectSugar = 5;

  void initState() {
    super.initState();
    nameController.text = widget.drinkName;
    descriptionController.text = widget.drinkDescription;
    priceController.text = widget.drinkUnitPrice;
  }

  Widget customRadioVolume(String category, int index) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectVolume = index;
          });
        },
        child: AnimatedContainer(
          child: Center(
            child: (category == "no") 
            ? Icon(Iconsax.slash, size: 12, color: blackLight)
            : Text(
              category,
              style: TextStyle(
                fontFamily: "SFProText",
                fontSize: 10.0,
                color: blackLight,
                fontWeight: FontWeight.w500,
              ),
            )
          ),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          height: 24,
          width: 64,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: blueLight),
              left: BorderSide(width: 1, color: blueLight),
              right: BorderSide(width: 1, color: blueLight),
              bottom: BorderSide(width: 1, color: blueLight),
            ),
            borderRadius: BorderRadius.circular(4),
            color: (selectVolume == index)
                ? blueLight
                : null,
            // boxShadow: [
            //   BoxShadow(
            //     color: black.withOpacity(0.1),
            //     spreadRadius: 0,
            //     blurRadius: 8,
            //     offset: Offset(0, 4),
            //   ),
            // ],
          ),
        ),
      )
    );
  }

  Widget customRadioCondition(String category, int index) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectCondition = index;
          });
        },
        child: AnimatedContainer(
          child: Center(
            child: (category == "no") 
            ? Icon(Iconsax.slash, size: 12, color: blackLight)
            : Text(
              category,
              style: TextStyle(
                fontFamily: "SFProText",
                fontSize: 10.0,
                color: blackLight,
                fontWeight: FontWeight.w500,
              ),
            )
          ),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          height: 24,
          width: 64,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: blueLight),
              left: BorderSide(width: 1, color: blueLight),
              right: BorderSide(width: 1, color: blueLight),
              bottom: BorderSide(width: 1, color: blueLight),
            ),
            borderRadius: BorderRadius.circular(4),
            color: (selectCondition == index)
                ? blueLight
                : null,
            // boxShadow: [
            //   BoxShadow(
            //     color: black.withOpacity(0.1),
            //     spreadRadius: 0,
            //     blurRadius: 8,
            //     offset: Offset(0, 4),
            //   ),
            // ],
          ),
        ),
      )
    );
  }

  Widget customRadioSugar(String category, int index) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectSugar = index;
          });
        },
        child: AnimatedContainer(
          child: Center(
            child: (category == "no") 
            ? Icon(Iconsax.slash, size: 12, color: blackLight)
            : Text(
              category,
              style: TextStyle(
                fontFamily: "SFProText",
                fontSize: 10.0,
                color: blackLight,
                fontWeight: FontWeight.w500,
              ),
            )
          ),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          height: 24,
          width: 64,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: blueLight),
              left: BorderSide(width: 1, color: blueLight),
              right: BorderSide(width: 1, color: blueLight),
              bottom: BorderSide(width: 1, color: blueLight),
            ),
            borderRadius: BorderRadius.circular(4),
            color: (selectSugar == index)
                ? blueLight
                : null,
            // boxShadow: [
            //   BoxShadow(
            //     color: black.withOpacity(0.1),
            //     spreadRadius: 0,
            //     blurRadius: 8,
            //     offset: Offset(0, 4),
            //   ),
            // ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: Scaffold(
          body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundDrink), fit: BoxFit.cover),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 455),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: appPadding,
                      right: appPadding,
                      bottom: appPadding + 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Container(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 20.0,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Form(
                          key: nameFormKey,
                          child: Container(
                            width: 319,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: blueLight),
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: content14,
                                    color: blackLight,
                                    fontWeight: FontWeight.w400),
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                //validator
                                validator: (name) {
                                  if (isNameValid(name.toString())) {
                                    return null;
                                  } else {
                                    return '';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 12),
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8),
                                  hintText: "Enter new drink's name",
                                  filled: true,
                                  fillColor: blueLight,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                    height: 0,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 20.0,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Form(
                          key: descriptionFormKey,
                          child: Container(
                            width: 319,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: blueLight),
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: content14,
                                    color: blackLight,
                                    fontWeight: FontWeight.w400),
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                //validator
                                validator: (description) {
                                  if (isDescriptionValid(description.toString())) {
                                    return null;
                                  } else {
                                    return '';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 12),
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8),
                                  hintText: "Enter new drink's description",
                                  filled: true,
                                  fillColor: blueLight,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                    height: 0,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        child: Text(
                          'Unit Price',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 20.0,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Form(
                          key: priceFormKey,
                          child: Container(
                            width: 319,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: blueLight),
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: content14,
                                    color: blackLight,
                                    fontWeight: FontWeight.w400),
                                controller: priceController,
                                keyboardType: TextInputType.text,
                                //validator
                                validator: (price) {
                                  if (isPriceValid(price.toString())) {
                                    return null;
                                  } else {
                                    return '';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 0),
                                  suffixIcon: Icon(Iconsax.dollar_square, size: 20),
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8),
                                  hintText: "Enter new drink's unit price",
                                  filled: true,
                                  fillColor: blueLight,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                    height: 0,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 62),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(left: 28),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Iconsax.arrow_square_left,
                            size: 32, color: blackLight),
                      ),
                      Spacer(),
                      Container(
                          child: GestureDetector(
                        onTap: () => removeDrinkDialog(context, widget.drinkID),
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 300),
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
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
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 64,
                                  offset: Offset(8, 8)),
                              BoxShadow(
                                color: black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Container(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              child: Icon(Iconsax.close_circle,
                                  size: 18, color: white)),
                        ),
                      )),
                      SizedBox(width: 8),                      
                      Container(
                          child: GestureDetector(
                        onTap: () {
                          // removeDialog(context);
                          setState(() {
                            nameController.text = "";
                            descriptionController.text = "";
                            priceController.text = "";
                          });
                          showSnackBar(context, "The drink's details have been reset!", "success");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => svDrinkCartScreen(),
                          //   ),
                          // );
                          // // .then((value) {});
                        },
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 300),
                          height: 32,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 64,
                                  offset: Offset(8, 8)),
                              BoxShadow(
                                color: black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Container(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                  fontFamily: "SFProText",
                                  fontSize: 14.0,
                                  color: black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      )),
                      SizedBox(width: 8),
                      Container(
                          padding: EdgeInsets.only(right: 28),
                          child: GestureDetector(
                            onTap: () {
                              if (nameFormKey.currentState!.validate() && descriptionFormKey.currentState!.validate() && priceFormKey.currentState!.validate()) {
                                controlUpdateDrink();
                              } else {
                                showSnackBar(context, 'Please fill in all information or enter a valid unit price!', 'danger');
                              }
                              // removeDialog(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => svDrinkCartScreen(),
                              //   ),
                              // );
                              // // .then((value) {});
                            },
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: Duration(milliseconds: 300),
                              height: 32,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                                boxShadow: [
                                  BoxShadow(
                                      color: black.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 64,
                                      offset: Offset(8, 8)),
                                  BoxShadow(
                                    color: black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      fontFamily: "SFProText",
                                      fontSize: 14.0,
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 56),
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                            child: displayDrinkImage(widget.drinkImageURL, 300, 300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16)
                ]))
          ],
        )
      ])),
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

  controlUpdateDrink() async {
    var doc = await drinksReference.doc(widget.drinkID).get();
    if (doc.exists) {
      drinksReference.doc(widget.drinkID).update({
        "name": nameController.text,
        "description": descriptionController.text,
        "unit price": priceController.text,
      });
      Navigator.pop(context);
      showSnackBar(context, "The drink's details have been updated!", 'success');
    }
    else {
      Navigator.pop(context);
      showSnackBar(context, "Failed to update the drink's details because it no longer exists.", 'error');
    }
  }
}


//Create validation
mixin InputValidationMixin {
  // bool isEmailValid(String email) {
  //   RegExp regex = new RegExp(
  //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  //   return regex.hasMatch(email);
  // }

  bool isNameValid(String name) => name.length >= 1;

  bool isDescriptionValid(String name) => name.length >= 1;

  bool isPriceValid(String name) => name.contains(new RegExp(r'[0-9]'));

  // bool isPasswordValid(String password) => password.length >= 6;

  // bool isPhoneNumberValid(String phoneNumber) {
  //   RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  //   return regex.hasMatch(phoneNumber);
  // }
}
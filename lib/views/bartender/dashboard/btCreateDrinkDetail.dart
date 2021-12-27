import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

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

class btCreateDrinkDetailScreen extends StatefulWidget {
  btCreateDrinkDetailScreen({Key? key}) : super(key: key);

  @override
  _btCreateDrinkDetailScreenState createState() =>
      _btCreateDrinkDetailScreenState();
}

class _btCreateDrinkDetailScreenState
    extends State<btCreateDrinkDetailScreen> {

  String volume = "";
  String condition = "";
  String sugar = "";

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> priceFormKey = GlobalKey<FormState>();

  int selected = 0;

  Widget customRadio(String category, int index) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = index;
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
            color: (selected == index)
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

  void initState() {
    super.initState();
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
                                // //validator
                                // validator: (password) {
                                //   if (isPasswordValid(password.toString())) {
                                //     return null;
                                //   } else {
                                //     return '';
                                //   }
                                // },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 12),
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8),
                                  hintText: "Enter the drink's name",
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
                                // //validator
                                // validator: (password) {
                                //   if (isPasswordValid(password.toString())) {
                                //     return null;
                                //   } else {
                                //     return '';
                                //   }
                                // },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 12),
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8),
                                  hintText: "Enter the drink's description",
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
                                // //validator
                                // validator: (password) {
                                //   if (isPasswordValid(password.toString())) {
                                //     return null;
                                //   } else {
                                //     return '';
                                //   }
                                // },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 0),
                                  suffixIcon: Icon(Iconsax.dollar_square, size: 20),
                                  hintStyle: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontSize: content14,
                                      fontWeight: FontWeight.w400,
                                      color: grey8),
                                  hintText: "Enter the drink's unit price",
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
                          'Option',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 20.0,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Volume:',
                              style: TextStyle(
                                fontFamily: "SFProText",
                                fontSize: 14.0,
                                color: blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Row(
                            children: [
                              customRadio('500ml', 1),
                              SizedBox(width: 16),
                              customRadio('1000ml', 2),
                              SizedBox(width: 16),
                              customRadio('no', 3),
                            ],
                          ),
                        ]
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Condition:',
                              style: TextStyle(
                                fontFamily: "SFProText",
                                fontSize: 14.0,
                                color: blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Row(
                            children: [
                              customRadio('Cold', 1),
                              SizedBox(width: 16),
                              customRadio('Hot', 2),
                              SizedBox(width: 16),
                              customRadio('no', 3),
                            ],
                          ),
                        ]
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Sugar:',
                              style: TextStyle(
                                fontFamily: "SFProText",
                                fontSize: 14.0,
                                color: blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Column(
                            children: [
                              Row(
                                children: [
                                  customRadio('100%', 1),
                                  SizedBox(width: 16),
                                  customRadio('70%', 2),
                                  SizedBox(width: 16),
                                  customRadio('50%', 3),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  customRadio('30%', 4),
                                  SizedBox(width: 16),
                                  customRadio('0%', 5),
                                  SizedBox(width: 16),
                                  customRadio('no', 6),
                                ],
                              ),
                            ],
                          )
                        ]
                      ),
                      SizedBox(height: 24),
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
                          padding: EdgeInsets.only(right: 28),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
                                    "Create",
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
                            child: Image.network(
                                'https://i.imgur.com/6GfgeBS.png',
                                scale: 4.926)),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
                            margin: EdgeInsets.only(left: 260, top: 256),
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: blueWater,
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
                              alignment: Alignment.center,
                              child: Icon(Iconsax.edit, size: 18, color: white)
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 16)
                ]))
          ],
        )
      ])),
    );
  }
}

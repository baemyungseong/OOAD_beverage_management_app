import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

//import models
import 'package:ui_fresh_app/models/cartItemModel.dart';

//import others
import 'package:meta/meta.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';

class svDrinkCartScreen extends StatefulWidget {
  svDrinkCartScreen({Key? key}): super(key: key);

  @override
  _svDrinkCartScreenState createState() => _svDrinkCartScreenState();
}

class _svDrinkCartScreenState extends State<svDrinkCartScreen> {

  _svDrinkCartScreenState();

  List<CartItem> cartItems = [];

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: blueLight
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 62),
                IconButton(
                  padding: EdgeInsets.only(left: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Iconsax.arrow_square_left,
                      size: 32, color: blackLight),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    "My Cart",
                    style: TextStyle(
                        fontFamily: "SFProText",
                        fontSize: 24.0,
                        color: black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  height: 660,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    )
                  ),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 660,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                            child: FutureBuilder(
                              future: getDrinksInCart(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: SizedBox(
                                      child: CircularProgressIndicator(
                                        color: blackLight,
                                        strokeWidth: 3,
                                      ),
                                      height: 25.0,
                                      width: 25.0,
                                    ),
                                  );                                  
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 32),
                                    ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: cartItems.length,
                                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 32),
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          // key: ValueKey(index), 
                                          key: UniqueKey(), 
                                          background: Container(
                                            padding: EdgeInsets.only(right: 24),
                                            alignment: Alignment.centerRight,
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
                                                ]
                                              ),
                                            ),
                                            child: Icon(Iconsax.minus, size: 56, color: white)
                                          ),
                                          onDismissed: (direction) async {
                                            setState(() {
                                              // lista.removeAt(index);
                                            });
                                            showSnackBar(context, 'The drink has been removed from the cart!', 'success');
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                            },
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(left: 20, top: 8, right: 3, bottom: 8),
                                              height: 150,
                                              width: 370,
                                              color: white,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Container(
                                                      child: displayDrinkImage(cartItems[index].image, 100, 100)
                                                    ),
                                                  ),
                                                  SizedBox(width: 24),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 207,
                                                        padding: EdgeInsets.zero,
                                                        child: Text(
                                                          cartItems[index].name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: blackLight,
                                                            fontSize: title24,
                                                            fontWeight: FontWeight.w700,
                                                            fontFamily: 'SFProText',
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        width: 223,
                                                        padding: EdgeInsets.zero,
                                                        child: Text(
                                                          cartItems[index].description,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: grey8,
                                                            fontSize: content12,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'SFProText',
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                      SizedBox(height: 12),
                                                      Container(
                                                        width: 223,
                                                        padding: EdgeInsets.zero,
                                                        child: Text(
                                                          cartItems[index].options,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: blackLight,
                                                            fontSize: content12,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: 'SFProText',
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: IconButton(
                                                                    padding: EdgeInsets.zero,
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        if(quantity > 1) {
                                                                          quantity--;
                                                                        }
                                                                      });
                                                                    },
                                                                    icon: Icon(Iconsax.minus_square,
                                                                        size: 24, color: blackLight),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  width: 51,
                                                                  padding: EdgeInsets.zero,
                                                                  child: Text(
                                                                    cartItems[index].quantity,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
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
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: IconButton(
                                                                    padding: EdgeInsets.zero,
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        if(quantity < 99) {
                                                                          quantity++;
                                                                        }
                                                                      });
                                                                    },
                                                                    icon: Icon(Iconsax.add_square,
                                                                        size: 24, color: blackLight),
                                                                  ),
                                                                )
                                                              ]
                                                            )
                                                          ),
                                                          SizedBox(width: 55),
                                                          Container(
                                                            width: 69,
                                                            alignment: Alignment.centerRight,
                                                            // width: 319,
                                                            child: Text(
                                                              "\$ " + (int.parse(cartItems[index].quantity) * int.parse(cartItems[index].unit_price)).toString() + ".0",
                                                              style: TextStyle(
                                                                color: blackLight,
                                                                fontSize: title20,
                                                                fontWeight: FontWeight.w600,
                                                                fontFamily: 'SFProText',
                                                              ),
                                                              textAlign: TextAlign.right,
                                                            ),
                                                          ),
                                                        ]
                                                      )
                                                    ]
                                                  )
                                                ]
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                    SizedBox(height: 32),
                                  ]
                                );
                              },
                            ),
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getDrinksInCart() async {
    cartItems.clear();
    QuerySnapshot querySnapshot = await cartsReference.doc(currentUser.id).collection("myCart").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      CartItem cartItem =  CartItem();
      cartItem = CartItem.fromDocument(doc);
      cartItems.add(cartItem);
    }
    cartItems.sort((a, b) => a.timestamp.compareTo(b.timestamp));
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
}

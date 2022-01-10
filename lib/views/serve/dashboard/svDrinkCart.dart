import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

//import models
import 'package:ui_fresh_app/models/cartItemModel.dart';
import 'package:ui_fresh_app/models/orderDetailModel.dart';

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

  List<OrderDetail> orderDetails = [];

  int totalMoney = 0;
  
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
                                  return Container(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Center(
                                      child: SizedBox(
                                        child: CircularProgressIndicator(
                                          color: blackLight,
                                          strokeWidth: 3,
                                        ),
                                        height: 25.0,
                                        width: 25.0,
                                      ),
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
                                          key: UniqueKey(),
                                          direction: DismissDirection.endToStart, 
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
                                          onDismissed: (direction) {
                                            setState(() {
                                              controlRemoveDrink(cartItems[index].id);
                                            });
                                          },
                                          child: Container(
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(left: 20, top: 8, right: 3, bottom: 8),
                                              height: 150,
                                              width: 370,
                                              color: Colors.transparent,
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
                                                                        if(int.parse(cartItems[index].quantity) > 1) {
                                                                          controlDecreaseQuantity(cartItems[index].id, cartItems[index].quantity);
                                                                        }
                                                                        else {
                                                                          showSnackBar(context, "Quantity must not be zero ", "error");
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
                                                                        if(int.parse(cartItems[index].quantity) < 99) {
                                                                          controlIncreaseQuantity(cartItems[index].id, cartItems[index].quantity);
                                                                        }
                                                                        else {
                                                                          showSnackBar(context, "Quantity must be below 100", "error");
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
                                    cartItems.isEmpty ? Container() : Container(
                                      padding: EdgeInsets.only(right: 20, bottom: 30),
                                      child: GestureDetector(
                                        onTap: () => controlAddNewOrder(),
                                        child: AnimatedContainer(
                                          alignment: Alignment.center,
                                          duration: Duration(milliseconds: 300),
                                          height: 48,
                                          width: 180,
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
                                            "Confirm Order",
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'SFProText',
                                                fontWeight: FontWeight.w600,
                                                fontSize: textButton16),
                                          ),
                                        ),
                                      ), 
                                    ),                                   
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

  controlIncreaseQuantity(String _id, String _quantity) {
    String _quantityIncreased = (int.parse(_quantity) + 1).toString();
    cartsReference.doc(currentUser.id).collection("myCart").doc(_id).update({
      "quantity": _quantityIncreased,
    });
  }

  controlDecreaseQuantity(String _id, String _quantity) {
    String _quantityDecreased = (int.parse(_quantity) - 1).toString();
    cartsReference.doc(currentUser.id).collection("myCart").doc(_id).update({
      "quantity": _quantityDecreased,
    });
  }

  controlRemoveDrink(String _id) {
    cartsReference.doc(currentUser.id).collection("myCart").doc(_id).delete().whenComplete((){
      showSnackBar(context, "Drink removed from your cart successfully!", "success");
    });
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

  addItemsToOrderDetails() {
    orderDetails.clear();
    for (int i = 0; i < cartItems.length; i++) {
      OrderDetail orderDetail = OrderDetail();
      orderDetail.name = cartItems[i].name + " x " + cartItems[i].quantity;
      orderDetail.options = cartItems[i].options;
      orderDetail.quantity = cartItems[i].quantity;
      orderDetail.price = (int.parse(cartItems[i].unit_price) * int.parse(cartItems[i].quantity)).toString();
      orderDetails.add(orderDetail);
    }
    for (int i = 0; i < orderDetails.length; i++) {
      totalMoney = totalMoney + int.parse(orderDetails[i].price);
    }
  }

  controlAddNewOrder() async {
    addItemsToOrderDetails();
    List orderDetailsList = [];
    for (int i = 0; i < orderDetails.length; i++)
      orderDetailsList.add({
        "name": orderDetails.toList()[i].name,
        "options": orderDetails.toList()[i].options,
        "quantity": orderDetails.toList()[i].quantity,
        "price": orderDetails.toList()[i].price,        
    });
    var rand = new Random();
    var orderCode = rand.nextInt(9000) + 1000;
    List<String> myUserId = [currentUser.id];
    ordersReference.add({
      "id": "",
      "serveId": currentUser.id,
      "code": "#" + orderCode.toString(),
      "staffs": FieldValue.arrayUnion(myUserId),
      "details": FieldValue.arrayUnion(orderDetailsList),
      "total money": totalMoney.toString(),
      "isCheckedOutByServe": "false",
      "isCheckedOutByBartender": "false",
      "isCheckedOutByAccountant": "false", 
      "isConfirmedPurchased": "false",           
      "timestamp": DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()),
    }).then(
      (DocumentReference docRef) => docRef.update({"id": docRef.id})
    ).whenComplete(() async {
      await cartsReference.doc(currentUser.id).collection("myCart").get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }        
      });
    });
    Navigator.pop(context);
    showSnackBar(context, "Added to orders list successfully!", "success");    
  }
}

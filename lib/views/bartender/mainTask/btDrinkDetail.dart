import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/dialogWidget.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import models
import 'package:ui_fresh_app/models/orderModel.dart';
import 'package:ui_fresh_app/models/appUser.dart';
import 'package:ui_fresh_app/models/orderDetailModel.dart';

//import others
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class btDrinkDetailScreen extends StatefulWidget {
  String id;
  String code;
  DateTime timestamp;
  String totalMoney;

  btDrinkDetailScreen(this.id, this.code, this.timestamp, this.totalMoney, {Key? key}) : super(key: key);

  @override
  _btDrinkDetailScreenState createState() => _btDrinkDetailScreenState();
}

class _btDrinkDetailScreenState extends State<btDrinkDetailScreen> {
  TextEditingController troubleNameController = TextEditingController();

  Order order = Order();
  
  List<appUser> orderStaffs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(background), fit: BoxFit.cover),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80 + 28),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: appPadding,
                        right: appPadding,
                        bottom: appPadding + 8),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Container(
                                        child: Text(
                                          "Order " + widget.code,
                                          style: TextStyle(
                                            fontFamily: "SFProText",
                                            fontSize: 24.0,
                                            color: black,
                                            fontWeight: FontWeight.w700,
                                            height: 1.6,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Container(
                                        width: 319,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: blueLight,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Icon(Iconsax.clock,
                                                size: 20, color: blueWater),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                              "Time: ",
                                              style: TextStyle(
                                                fontFamily: "SFProText",
                                                fontSize: content14,
                                                color: grey8,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              DateFormat("MMMM dd yyyy, ").format(widget.timestamp) + "at " + DateFormat("hh:mm a").format(widget.timestamp),
                                              style: TextStyle(
                                                fontFamily: "SFProText",
                                                fontSize: content14,
                                                color: blackLight,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Container(
                                        child: Text(
                                          "Staffs",
                                          style: TextStyle(
                                            fontFamily: "SFProText",
                                            fontSize: title20,
                                            color: blackLight,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      FutureBuilder(
                                        future: getOrderStaffs(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(
                                              child: 
                                                SizedBox(
                                                  child: CircularProgressIndicator(
                                                    color: blackLight,
                                                    strokeWidth: 3,
                                                  ),
                                                  height: 25.0,
                                                  width: 25.0,
                                                ),
                                            );
                                          }
                                          return Container(
                                            child: ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: order.staffs.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      SizedBox(height: 12),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: blueLight,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8)),
                                                    height: 64,
                                                    width: 319,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(width: 16),
                                                              AnimatedContainer(
                                                                alignment: Alignment
                                                                    .center,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                height: 36,
                                                                width: 36,
                                                                child: displayAvatar(orderStaffs[index].avatar),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: blueWater,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                ),
                                                              ),
                                                              SizedBox(width: 16),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        width: 168,
                                                                        child: Text(
                                                                         orderStaffs[index].name,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                content14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                blackLight,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width: 43 -
                                                                              24),
                                                                      Container(
                                                                        padding: EdgeInsets.only(top: 14, right: 12),
                                                                        child: Container(
                                                                        height: 20,
                                                                        width: 70,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  4.0),
                                                                          color:
                                                                              blueWater,
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            StringUtils.capitalize(orderStaffs[index].role),
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily:
                                                                                  'SFProText',
                                                                              fontSize:
                                                                                  content10,
                                                                              fontWeight:
                                                                                  FontWeight.w500,
                                                                              color:
                                                                                  white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: 2),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Iconsax.sms,
                                                                        color:
                                                                            blackLight,
                                                                        size: 12,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 4,
                                                                      ),
                                                                      Text(
                                                                        orderStaffs[index].email,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          fontSize:
                                                                              content8,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color:
                                                                              grey8,
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
                                          );
                                        }
                                      ),
                                      SizedBox(height: 24),
                                      Container(
                                        child: Text(
                                          "Details of Order",
                                          style: TextStyle(
                                            fontFamily: "SFProText",
                                            fontSize: title20,
                                            color: blackLight,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      FutureBuilder(
                                        future: getOrderDetails(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(
                                              child: 
                                                SizedBox(
                                                  child: CircularProgressIndicator(
                                                    color: blackLight,
                                                    strokeWidth: 3,
                                                  ),
                                                  height: 25.0,
                                                  width: 25.0,
                                                ),
                                            );
                                          }
                                          return Container(
                                            child: ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: order.orderDetails.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      SizedBox(
                                                height: 1,
                                                child: Divider(
                                                    color: grey8, thickness: 0.2),
                                              ),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: (index == 0 ||
                                                          index == order.orderDetails.length - 1)
                                                      ? (index == 0)
                                                          ? BoxDecoration(
                                                              color: white,
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                        8),
                                                                topRight:
                                                                    Radius.circular(
                                                                        8),
                                                              ),
                                                            )
                                                          : BoxDecoration(
                                                              color: white,
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                        8),
                                                              ),
                                                            )
                                                      : BoxDecoration(
                                                          color: white,
                                                        ),
                                                  width: 319,
                                                  height: 48,
                                                  padding: EdgeInsets.only(
                                                      top: 8,
                                                      left: 16,
                                                      bottom: 8,
                                                      right: 16),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: blueLight,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                              Radius.circular(8),
                                                            )),
                                                        height: 30,
                                                        width: 30,
                                                        child: Center(
                                                          child: Text(
                                                            '${index + 1}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "SFProText",
                                                              fontSize: content16,
                                                              color: blackLight,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 16),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  order.orderDetails[index].name,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "SFProText",
                                                                      fontSize:
                                                                          content12,
                                                                      color:
                                                                          blackLight,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      height: 1.4),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 2),
                                                          Container(
                                                            child: Text(
                                                              order.orderDetails[index].options,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "SFProText",
                                                                fontSize: content8,
                                                                color: grey8,
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "+ \$ " + order.orderDetails[index].price + ".00",
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow: TextOverflow.fade,
                                                        style: TextStyle(
                                                          fontSize: content14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'SFProText',
                                                          foreground: Paint()
                                                            ..shader =
                                                                greenGradient,
                                                        ),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );                                          
                                        }
                                      ),
                                      SizedBox(height: 24),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total Money:',
                                            style: TextStyle(
                                              fontFamily: "SFProText",
                                              fontSize: content16,
                                              color: blackLight,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "+ \$ " + widget.totalMoney + ".00",
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'SFProText',
                                              foreground: Paint()
                                                ..shader = blueGradient,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 40),
                                      Container(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () => checkoutDialog(context, widget.id, orderStaffs),
                                            child: AnimatedContainer(
                                              alignment: Alignment.center,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              height: 48,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: blackLight,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        black.withOpacity(0.25),
                                                    spreadRadius: 0,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        4), // changes position of shadow
                                                  ),
                                                  BoxShadow(
                                                    color:
                                                        black.withOpacity(0.1),
                                                    spreadRadius: 0,
                                                    blurRadius: 64,
                                                    offset: Offset(15,
                                                        15), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: 
                                                  Container(
                                                      child: Text(
                                                      "Check Out",
                                                      style: TextStyle(
                                                          color: whiteLight,
                                                          fontFamily:
                                                              'SFProText',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              textButton20),
                                                    )),
                                            ),
                                          )),
                                      SizedBox(height: 24)
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 62),
                  child: Row(
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
                            onTap: () => dialogRemoveOrder(context, widget.id),
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
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  getOrderDetails() async {
    List details = [];
    await ordersReference.doc(widget.id).get().then(
      (value) {
        List.from(value.data()!["details"]).forEach((element) {
          details.add(element);
         });
      }
    );
    order.orderDetails.clear();
    for (int i = 0; i < details.length; i++) {
      OrderDetail orderDetail = OrderDetail();
      orderDetail.name = details[i]["name"];
      orderDetail.options = details[i]["options"];
      orderDetail.price = details[i]["price"];
      orderDetail.quantity = details[i]["quantity"];
      order.orderDetails.add(orderDetail);
    }
  }

  getOrderStaffs() async {
    order.staffs.clear();
    await ordersReference.doc(widget.id).get().then(
      (value) {
        List.from(value.data()!["staffs"]).forEach((element) {
          order.staffs.add(element);
        });
      }
    );
    List<appUser> _tempStaffs = [];
    QuerySnapshot querySnapshot = await userReference.get();
    orderStaffs.clear();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      appUser user = appUser();
      user = appUser.fromDocument(doc);
      _tempStaffs.add(user);
    }
    for (int i = 0; i < order.staffs.length; i++) {
      for (int j = 0; j < _tempStaffs.length; j++) {
        if (_tempStaffs[j].id == order.staffs[i]) {
          orderStaffs.add(_tempStaffs[j]);
        }
      }
    }    
  }
}

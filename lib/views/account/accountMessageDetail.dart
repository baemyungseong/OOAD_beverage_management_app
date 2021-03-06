import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';

//import others
import 'package:meta/meta.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:ui_fresh_app/models/appUser.dart';
import 'package:ui_fresh_app/models/contentModel.dart';

class messageDetailScreen extends StatefulWidget {
  String uid;
  String uid2;
  String messagesId;
  messageDetailScreen(Required required,
      {Key? key,
      required this.uid,
      required this.uid2,
      required this.messagesId})
      : super(key: key);

  @override
  _messageDetailScreenState createState() =>
      _messageDetailScreenState(uid, uid2, this.messagesId);
}

class _messageDetailScreenState extends State<messageDetailScreen> {
  String uid = '';
  String uid2 = '';
  String messagesId = "";
  _messageDetailScreenState(this.uid, this.uid2, this.messagesId);
  late Content content = Content(
      contentId: '',
      userId: '',
      messageId: '',
      message: '',
      createAt: '',
      timeSendDetail: '');
  late appUser user = appUser();
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> messageFormKey = GlobalKey<FormState>();
  String message = '';

  Future getUserDetail() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: uid)
        .snapshots()
        .listen((value) {
      setState(() {
        user = appUser.fromDocument(value.docs.first);
        print(user.name);
      });
    });
  }

  late DateTime date = DateTime.now();
  Future sendMessage() async {
    if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("contents").add({
        'content': messageController.text,
        'sendBy': currentUser.id,
        'messageId': messagesId,
        'timeSend': "${DateFormat('hh:mm a').format(DateTime.now())}",
        'timeSendDetail': "$date"
      }).then((value) {
        FirebaseFirestore.instance
            .collection("messages")
            .doc(messagesId)
            .update({
          'contentList': FieldValue.arrayUnion([value.id]),
        });
        FirebaseFirestore.instance.collection("contents").doc(value.id).update({
          'contentId': value.id,
        });
      });
      FirebaseFirestore.instance.collection("messages").doc(messagesId).update({
        'lastMessage': messageController.text,
        'lastTimeSend': "${DateFormat('hh:mm a').format(DateTime.now())}",
      });
    }
  }

  late List contentList;
  late List<Content> chatting = [];

  Future getMessage2() async {
    FirebaseFirestore.instance
        .collection("messages")
        .doc(messagesId)
        .snapshots()
        .listen((value1) {
      FirebaseFirestore.instance
          .collection("contents")
          .orderBy('timeSendDetail', descending: false)
          .get()
          .then((value2) {
        setState(() {
          chatting.clear();
          contentList = value1.data()!["contentList"];
          value2.docs.forEach((element) {
            if (contentList.contains(element.data()['contentId'] as String)) {
              chatting.add(Content.fromDocument(element.data()));
            }
          });
        });
      });
    });
  }

  void initState() {
    super.initState();
    getUserDetail();
    getMessage2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: blueLight),
          ),
          Container(
            // scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 62),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(left: 28),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, size: 28, color: black),
                    ),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         Screen(required, uid: uid),
                            //   ),
                            // );
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: blueWater,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 64,
                                  offset: Offset(8, 8),
                                ),
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
                                child:
                                    Icon(Iconsax.call, size: 18, color: white)),
                          ),
                        )),
                    SizedBox(width: 8),
                    Container(
                        padding: EdgeInsets.only(right: 28),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         Screen(required, uid: uid),
                            //   ),
                            // );
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: blueWater,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 64,
                                  offset: Offset(8, 8),
                                ),
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
                                child: Icon(Iconsax.video,
                                    size: 18, color: white)),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    user.name,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 24.0,
                        color: black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 640 - 31,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36.0),
                        topRight: Radius.circular(36.0),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 518,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 32),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 28, right: 28),
                                      child: ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  SizedBox(height: 16),
                                          itemCount: chatting.length,
                                          itemBuilder: (context, index) {
                                            return (currentUser.id ==
                                                    chatting[index].userId)
                                                ? Container(
                                                    // padding: EdgeInsets.only(
                                                    //     left: 28, right: 28),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          chatting[index]
                                                              .createAt,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 10.0,
                                                              color: grey8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      264),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 16,
                                                                  left: 24,
                                                                  bottom: 16,
                                                                  right: 24),
                                                          // height: 73,
                                                          // width: 236 - 12,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        24.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        24.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        24.0)),
                                                            color: blueLight,
                                                          ),
                                                          child: Text(
                                                            chatting[index]
                                                                .message,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 12.0,
                                                                color: black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    // padding: EdgeInsets.only(
                                                    //     left: 28, right: 28),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          width: 32,
                                                          height: 32,
                                                          decoration:
                                                              new BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    // '${projects[index]!["background"]}'),
                                                                    user.avatar),
                                                                fit: BoxFit.cover),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Container(
                                                          // height: 54,
                                                          // width: 172,
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      254),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 16,
                                                                  left: 24,
                                                                  bottom: 16,
                                                                  right: 24),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        24.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        24.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        24.0)),
                                                            color: whiteLight,
                                                          ),
                                                          child: Text(
                                                            chatting[index]
                                                                .message,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 12.0,
                                                                color: black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          chatting[index]
                                                              .createAt,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 10.0,
                                                              color: grey8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                          }),
                                    ),
                                  ],
                                ))),
                        SizedBox(height: 24),
                        Container(
                          height: 54,
                          width: 319,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 28, right: 28),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            color: blueLight,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 28),
                              Expanded(
                                  child: Form(
                                key: messageFormKey,
                                child: TextField(
                                    controller: messageController,
                                    // onChanged: (value) => setState(() {
                                    //       message = value;
                                    //     }),
                                    onEditingComplete: () {
                                      setState(() {
                                        sendMessage();
                                        getMessage2();
                                        messageController.clear();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: content14,
                                        color: grey8,
                                      ),
                                      hintText: "Type your message...",
                                    )),
                              )),
                              SizedBox(width: 20),
                              Container(
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 300),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: blueWater,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 64,
                                        offset: Offset(8, 8),
                                      ),
                                      BoxShadow(
                                        color: black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.only(right: 8),
                                      // padding: EdgeInsets.zero,
                                      alignment: Alignment.center,
                                      child: IconButton(
                                          icon: Icon(Iconsax.send1),
                                          iconSize: 18,
                                          color: white,
                                          onPressed: () {
                                            setState(() {
                                              sendMessage();
                                              getMessage2();
                                              messageController.clear();
                                            });
                                            setState(() {});
                                          })),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:ui_fresh_app/models/appUser.dart';
import 'package:ui_fresh_app/models/incidentReportModel.dart';
import 'package:ui_fresh_app/models/troubleModel.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/dialogWidget.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import others
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

class IncidentReportCreatingScreen extends StatefulWidget {
  IncidentReportCreatingScreen({Key? key}) : super(key: key);

  @override
  _IncidentReportCreatingScreenState createState() =>
      _IncidentReportCreatingScreenState();
}

class _IncidentReportCreatingScreenState
    extends State<IncidentReportCreatingScreen> with InputValidationMixin {
  TextEditingController troubleNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  GlobalKey<FormState> reasonFormKey = GlobalKey<FormState>();
  TextEditingController relatedController = TextEditingController();
  GlobalKey<FormState> relatedFormKey = GlobalKey<FormState>();

  bool isCheckout = false;
  bool isStatusValid = false;
  bool isDateValid = true;
  bool isTroubleValid = false;

  String statusIncident = '';

  late DateTime selectDate = DateTime.now();

  int selected = 0;

  IncidentReport incidentReport = IncidentReport(
      id: '',
      name: '',
      status: '',
      reason: '',
      performer: [],
      time: '',
      trouble: [],
      total: '',
      partyinTrouble: '');
  String newIdIncidentReport = '';
  Future createIncidentReport() async {
    FirebaseFirestore.instance.collection('incidentReports').add({
      'id': '',
      "name": nameController.text,
      "status": statusIncident,
      "reason": reasonController.text,
      "performer": performerIdList,
      "time": "${DateFormat('yMMMMd').format(selectDate)}" +
          ", at " +
          "${DateFormat('hh:mm a').format(selectDate)}",
      "detailOfTrouble": incidentReportList,
      "partyInTrouble": relatedController.text,
      'total': total.toStringAsFixed(0).toString(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection("incidentReports")
          .doc(value.id)
          .update({
        'id': newIdIncidentReport = value.id,
      });
    }).whenComplete(() => FirebaseFirestore.instance
        .collection("troubles")
        .get()
        .then((value) => value.docs.forEach((element) {
              if (incidentReportList.contains(element.data()['id'] as String)) {
                FirebaseFirestore.instance
                    .collection("troubles")
                    .doc(element.id)
                    .update({
                  'idIncidentReport': newIdIncidentReport,
                });
              }
            })));
  }

  String idIncidentReport = '';
  List incidentReportList = [];
  List<Trouble> troubleListCreate = [];
  double total = 0.0;
  String id = '';

  Future getTroubleListCreate(String idIncidentReport) async {
    FirebaseFirestore.instance.collection("troubles").get().then((value) {
      value.docs.forEach((element1) {
        setState(() {
          if (idIncidentReport.contains(element1.data()['id'] as String)) {
            incidentReportList.add(element1.data()['id'] as String);
            troubleListCreate.add(Trouble.fromDocument(element1.data()));
            if (element1.data()['category'] as String == 'Compensation') {
              total = (total + double.parse(element1.data()['money'] + ".0"));
            }
            if (element1.data()['category'] as String == 'Cost') {
              total = (total - double.parse(element1.data()['money'] + ".0"));
            }
          }
        });
      });
    });
  }

  List<appUser> performerList = [];
  List performerIdList = [];

  Future getPerformerList(String id) async {
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element1) {
        setState(() {
          if (id.contains(element1.data()['id'] as String)) {
            var check = performerList.where((element) => element.id == id);
            if (check.isEmpty) {
              performerIdList.add(element1.data()['id'] as String);
              performerList.add(appUser.fromDocument(element1));
            } else {
              showSnackBar(context, "This user was added ", "error");
            }
          }
        });
      });
    });
  }

  void initState() {
    super.initState();
  }

  Widget customRadio(String status, int index) {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            setState(() {
              selected = index;
              isStatusValid = true;
              statusIncident = status;
            });
          },
          child: AnimatedContainer(
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontFamily: "SFProText",
                  fontSize: 14.0,
                  color: (selected == index) ? white : black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            alignment: Alignment.center,
            duration: Duration(milliseconds: 300),
            height: 40,
            width: 122,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: blueLight),
                left: BorderSide(width: 2, color: blueLight),
                right: BorderSide(width: 2, color: blueLight),
                bottom: BorderSide(width: 2, color: blueLight),
              ),
              borderRadius: BorderRadius.circular(8),
              gradient: (selected == index)
                  ? (index == 1)
                      ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                              Color(0xFF159957),
                              Color(0xFF159199),
                            ],
                          stops: [
                              0.0,
                              1.0,
                            ])
                      : LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                              Color(0xFFCB356B),
                              Color(0xFFBD3F32),
                            ],
                          stops: [
                              0.0,
                              1.0,
                            ])
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
        ));
  }

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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: blueLight),
                                            alignment: Alignment.topCenter,
                                            child: TextFormField(
                                                style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content14,
                                                    color: blackLight,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                controller: nameController,
                                                keyboardType:
                                                    TextInputType.text,
                                                //validator
                                                validator: (name) {
                                                  if (isNameValid(
                                                      name.toString())) {
                                                    return null;
                                                  } else {
                                                    return '';
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontSize: content14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: grey8),
                                                  hintText: "Enter the name",
                                                  filled: true,
                                                  fillColor: blueLight,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
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
                                          'Datetime',
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
                                        child: GestureDetector(
                                          onTap: () async {
                                            String category = "dob";
                                            DateTime? dt =
                                                await datePickerDialog(context,
                                                    selectDate, category);
                                            if (dt != null) {
                                              selectDate = dt;
                                              setState(() {
                                                selectDate != selectDate;
                                              });
                                            }
                                            print(selectDate);
                                          },
                                          child: AnimatedContainer(
                                              alignment: Alignment.center,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              height: 48,
                                              width: 180,
                                              decoration: BoxDecoration(
                                                color: blueLight,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 12),
                                                  Container(
                                                      padding: EdgeInsets.zero,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Iconsax.calendar_1,
                                                        size: 16,
                                                        color: blackLight,
                                                      )),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "${DateFormat('yMMMMd').format(selectDate)}",
                                                    style: TextStyle(
                                                      color: grey8,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                ],
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Container(
                                        child: Text(
                                          'Status',
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 12),
                                            Column(
                                              children: [
                                                (currentUser.role == 'serve' ||
                                                        currentUser.role ==
                                                            'bartender')
                                                    ? Row(
                                                        children: [
                                                          customRadio(
                                                              'Processing', 2),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          customRadio(
                                                              'Done', 1),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          customRadio(
                                                              'Processing', 2),
                                                        ],
                                                      )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Container(
                                        child: Text(
                                          'Performer',
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
                                          child: Column(
                                        children: [
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: performerList.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    SizedBox(height: 12),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // watchUserDialog(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: blueLight,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  height: 48,
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              height: 32,
                                                              width: 32,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    blueWater,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        performerList[index]
                                                                            .avatar),
                                                                    fit: BoxFit
                                                                        .cover),
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
                                                                      width:
                                                                          168,
                                                                      child:
                                                                          Text(
                                                                        performerList[index]
                                                                            .name,
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
                                                                      height:
                                                                          16,
                                                                      width: 44,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(4.0),
                                                                        color:
                                                                            blueWater,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          performerList[index]
                                                                              .role,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                content6,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 4),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Iconsax
                                                                          .sms,
                                                                      color:
                                                                          blackLight,
                                                                      size: 12,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Text(
                                                                      performerList[
                                                                              index]
                                                                          .email,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            content8,
                                                                        fontWeight:
                                                                            FontWeight.w500,
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
                                          GestureDetector(
                                            onTap: () {
                                              addPerformerDialog(context, id)
                                                  .then((value) {
                                                setState(() {
                                                  print("value");
                                                  print(value);
                                                  getPerformerList(
                                                      value.toString());
                                                });
                                              });
                                            },
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                width: 319,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xFF5FAAEF),
                                                        Color(0xFF979DFA),
                                                      ],
                                                      stops: [
                                                        0.0,
                                                        1.0,
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 21),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(Iconsax.add,
                                                            size: 20,
                                                            color: white)),
                                                    SizedBox(width: 21),
                                                    Text(
                                                      "New Performer",
                                                      style: TextStyle(
                                                        color: white,
                                                        fontFamily: 'SFProText',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: content14,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )
                                        ],
                                      )),
                                      SizedBox(height: 24),
                                      Container(
                                        child: Text(
                                          'Reasons',
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
                                          key: reasonFormKey,
                                          child: Container(
                                            width: 319,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: blueLight),
                                            alignment: Alignment.topCenter,
                                            child: TextFormField(
                                                style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content14,
                                                    color: blackLight,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                controller: reasonController,
                                                keyboardType:
                                                    TextInputType.text,
                                                //validator
                                                validator: (reason) {
                                                  if (isReasonValid(
                                                      reason.toString())) {
                                                    return null;
                                                  } else {
                                                    return '';
                                                  }
                                                },
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
                                                      EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontSize: content14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: grey8),
                                                  hintText: "Enter the reasons",
                                                  filled: true,
                                                  fillColor: blueLight,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
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
                                          'Party in trouble',
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
                                          key: relatedFormKey,
                                          child: Container(
                                            width: 319,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: blueLight),
                                            alignment: Alignment.topCenter,
                                            child: TextFormField(
                                                style: TextStyle(
                                                    fontFamily: 'SFProText',
                                                    fontSize: content14,
                                                    color: blackLight,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                controller: relatedController,
                                                keyboardType:
                                                    TextInputType.text,
                                                //validator
                                                validator: (related) {
                                                  if (isRelatedValid(
                                                      related.toString())) {
                                                    return null;
                                                  } else {
                                                    return '';
                                                  }
                                                },
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
                                                      EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontSize: content14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: grey8),
                                                  hintText:
                                                      "Enter the party in trouble",
                                                  filled: true,
                                                  fillColor: blueLight,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
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
                                          'Details of trouble',
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
                                          child: Column(
                                        children: [
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: troubleListCreate.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    SizedBox(
                                              height: 1,
                                              child: Divider(
                                                  color: grey8, thickness: 0.2),
                                            ),
                                            itemBuilder: (context, index) {
                                              return Dismissible(
                                                onDismissed: (direction) {
                                                  // Remove the item from the data source.
                                                  setState(() {
                                                    troubleListCreate
                                                        .removeAt(index);
                                                    incidentReportList
                                                        .removeAt(index);
                                                  });
                                                },
                                                key: ValueKey(index),
                                                background: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 16),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            Color(0xFFCB356B),
                                                            Color(0xFFBD3F32),
                                                          ],
                                                          stops: [
                                                            0.0,
                                                            1.0,
                                                          ]),
                                                    ),
                                                    child: Icon(Iconsax.minus,
                                                        size: 24,
                                                        color: white)),
                                                child: Container(
                                                  decoration: (index == 0)
                                                      ? BoxDecoration(
                                                          color: white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8)),
                                                        )
                                                      : BoxDecoration(
                                                          color: white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          0)),
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
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    blueLight,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          8),
                                                                )),
                                                        height: 30,
                                                        width: 30,
                                                        child: Center(
                                                          child: Text(
                                                            '${index + 1}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "SFProText",
                                                              fontSize:
                                                                  content16,
                                                              color: blackLight,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                                  troubleListCreate[
                                                                          index]
                                                                      .name,
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
                                                                      height:
                                                                          1.4),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 0),
                                                              // Container(
                                                              //   child: Text(
                                                              //     (troubleListCreate[index].category == 'Compensation'
                                                              //       )
                                                              //         ? ' - '+ troubleListCreate[index].money
                                                              //         : ' +' + troubleListCreate[index].money,
                                                              //     style: TextStyle(
                                                              //         fontFamily:
                                                              //             "SFProText",
                                                              //         fontSize:
                                                              //             content12,
                                                              //         color:
                                                              //             blackLight,
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .w600,
                                                              //         height:
                                                              //             1.4),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 2),
                                                          Container(
                                                            child: Text(
                                                              troubleListCreate[
                                                                      index]
                                                                  .category,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "SFProText",
                                                                fontSize:
                                                                    content8,
                                                                color: grey8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        (troubleListCreate[
                                                                        index]
                                                                    .category ==
                                                                'Compensation')
                                                            ? '+\$' +
                                                                troubleListCreate[
                                                                        index]
                                                                    .money
                                                            : '-\$' +
                                                                troubleListCreate[
                                                                        index]
                                                                    .money,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                          fontSize: content14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'SFProText',
                                                          foreground: Paint()
                                                            ..shader = (troubleListCreate[
                                                                            index]
                                                                        .category ==
                                                                    'Compensation')
                                                                ? greenGradient
                                                                : redGradient,
                                                        ),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              addTroubleDialog(
                                                      context, idIncidentReport)
                                                  .then((value) {
                                                setState(() {
                                                  print("value");
                                                  print(value);
                                                  getTroubleListCreate(
                                                      value.toString());
                                                });
                                              });
                                            },
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                width: 319,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xFF5FAAEF),
                                                        Color(0xFF979DFA),
                                                      ],
                                                      stops: [
                                                        0.0,
                                                        1.0,
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 21),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(Iconsax.add,
                                                            size: 20,
                                                            color: white)),
                                                    SizedBox(width: 21),
                                                    Text(
                                                      "New Trouble",
                                                      style: TextStyle(
                                                        color: white,
                                                        fontFamily: 'SFProText',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: content14,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )
                                        ],
                                      )),
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
                                            (total < 0)
                                                ? '- \$' +
                                                    (total * (-1.0))
                                                        .toStringAsFixed(0)
                                                        .toString()
                                                : '+ \$' +
                                                    total
                                                        .toStringAsFixed(0)
                                                        .toString(),
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
                                      // SizedBox(height: 40),
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   child: GestureDetector(
                                      //     //action navigate to dashboard screen
                                      //     onTap: () {
                                      //       setState(() {
                                      //         checkoutDialog(context);
                                      //         isCheckout = true;
                                      //         // Navigator.pop(context);
                                      //       });
                                      //     },
                                      //     child: AnimatedContainer(
                                      //       alignment: Alignment.center,
                                      //       duration: Duration(milliseconds: 300),
                                      //       height: 48,
                                      //       width: 200,
                                      //       decoration: BoxDecoration(
                                      //         color: (isCheckout) ? white : blackLight,
                                      //         borderRadius:
                                      //             BorderRadius.all(Radius.circular(12)),
                                      //         boxShadow: [
                                      //           BoxShadow(
                                      //             color: black.withOpacity(0.25),
                                      //             spreadRadius: 0,
                                      //             blurRadius: 4,
                                      //             offset: Offset(
                                      //                 0, 4), // changes position of shadow
                                      //           ),
                                      //           BoxShadow(
                                      //             color: black.withOpacity(0.1),
                                      //             spreadRadius: 0,
                                      //             blurRadius: 64,
                                      //             offset: Offset(
                                      //                 15, 15), // changes position of shadow
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       child: (isCheckout)
                                      //       ? Container(
                                      //         child: Icon(Iconsax.refresh, size: 24, color: blackLight),
                                      //       )
                                      //       : Container(
                                      //         child: Text(
                                      //           "Checkout",
                                      //           style: TextStyle(
                                      //             color: whiteLight,
                                      //             fontFamily: 'SFProText',
                                      //             fontWeight: FontWeight.w600,
                                      //             fontSize: textButton20
                                      //           ),
                                      //         )
                                      //       ),
                                      //     ),
                                      //   )
                                      // ),
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
                      GestureDetector(
                        onTap: () {
                          if (nameFormKey.currentState!.validate() &&
                              reasonFormKey.currentState!.validate() &&
                              relatedFormKey.currentState!.validate() &&
                              isStatusValid == true) {
                            createIncidentReport();
                            Navigator.pop(context);
                            showSnackBar(
                                context,
                                'The incident report have been created!',
                                'success');
                          } else {
                            showSnackBar(context,
                                'Please complete all information!', 'danger');
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: 28),
                          width: 80,
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
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              'Create',
                              style: TextStyle(
                                fontFamily: "SFProText",
                                fontSize: 14.0,
                                color: white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
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

  bool isReasonValid(String name) => name.length >= 1;

  bool isRelatedValid(String name) => name.length >= 1;

  // bool isPasswordValid(String password) => password.length >= 6;

  // bool isPhoneNumberValid(String phoneNumber) {
  //   RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  //   return regex.hasMatch(phoneNumber);
  // }
}

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';

import 'package:ui_fresh_app/views/account/profileManagement.dart';
import 'package:ui_fresh_app/views/account/accountNotifications.dart';
import 'package:ui_fresh_app/views/account/accountMessages.dart';
import 'package:ui_fresh_app/views/accountant/atWidget/atRevenueAndExpenditureCardWidget.dart';
import 'package:ui_fresh_app/views/accountant/atWidget/atIncomeAndOutcomeDashboardWidget.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';

//import models
import 'package:ui_fresh_app/models/reexModel.dart';
import 'package:ui_fresh_app/models/transactionModel.dart';

// import others
import 'package:meta/meta.dart';
import 'package:iconsax/iconsax.dart';
import 'package:countup/countup.dart';
import 'package:percent_indicator/percent_indicator.dart';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';
import 'package:ui_fresh_app/views/widget/dialogWidget.dart';

class atDashboardScreen extends StatefulWidget {
  atDashboardScreen({Key? key}) : super(key: key);

  @override
  _atDashboardScreenState createState() => _atDashboardScreenState();
}

class _atDashboardScreenState extends State<atDashboardScreen>
    with SingleTickerProviderStateMixin {
  _atDashboardScreenState();

  String currentReexTime = DateFormat("dd/MM/yyyy").format(DateTime.now());
  double reDay = 0;
  double reWeek = 0;
  double reMonth = 0;
  double reYear = 0;
  String totalIncome = "0";
  String totalOutcome = "0";
  String totalTrans = "0";
  double percentIncomeTrans = 0;
  double totalRevTrans = 0; 

  List<Reex> reex = [];
  List<Trans> trans = [];

  List<Widget> revenueCards = [];

  double _currentPosition = 0;

  late AnimationController _animatedController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000))..addListener(() {
          _animatedController.forward();
         });
  late Animation<double> _animationRev = Tween<double>(begin: 0, end: percentIncomeTrans).animate(_animatedController);
  late Animation<double> _animationExp = Tween<double>(begin: percentIncomeTrans, end: 100).animate(_animatedController);

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 62),
                Container(
                  padding: EdgeInsets.only(right: 28),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: appPadding),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => profileManagementScreen(),
                              ),
                            ).then((value) {});
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: 32,
                            width: 32,
                            child: displayAvatar(currentUser.avatar),
                            decoration: BoxDecoration(
                              color: blueWater,
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 60,
                                  offset: Offset(10, 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                currentUser.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SFProText',
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2),
                              )),
                          SizedBox(height: 2),
                          Container(
                              // alignment: Alignment.topLeft,
                              child: Text(StringUtils.capitalize(currentUser.role),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'SFProText',
                                    color: grey8,
                                    fontWeight: FontWeight.w400,
                                    // height: 1.4
                                  ))),
                          SizedBox(height: 2)
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          accountNotificationsScreen(),
                                    ),
                                  ).then((value) {});
                                },
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 300),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: blackLight,
                                    borderRadius: BorderRadius.circular(8),
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
                                      child: Icon(Iconsax.notification,
                                          size: 18, color: white)),
                                ),
                              )),
                          SizedBox(width: 8),
                          Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          accountMessagesScreen(),
                                    ),
                                  ).then((value) {});
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
                                      child: Icon(Iconsax.message,
                                          size: 18, color: white)),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),                              
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 24.0,
                            color: black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Spacer(),
                    /*
                    Container(
                      padding: EdgeInsets.only(right: appPadding),
                      alignment: Alignment.center,
                      child: new DotsIndicator(
                          dotsCount: 4,
                          position: _currentPosition,
                          decorator: DotsDecorator(
                            spacing: const EdgeInsets.only(left: 4, right: 4),
                            color: blackLight.withOpacity(0.3),
                            activeColor: blackLight,
                            size: const Size.square(6.0),
                            activeSize: const Size(20.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          )),
                    ),
                    */
                  ],
                ),
                SizedBox(height: 24),
                RefreshIndicator(
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: FutureBuilder(
                      future: getReexInfo(),
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
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(color: Colors.transparent),
                              child: PageView.builder(
                                  controller: PageController(
                                      initialPage: 0,
                                      keepPage: true,
                                      viewportFraction: 1),
                                  itemCount: revenueCards.length,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (num) {
                                      if (num == revenueCards.length) {
                                        _currentPosition = 3.0;
                                      } else {
                                        _currentPosition = num.toDouble();
                                      }
                                  },
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 28, right: 28),
                                            child: revenueCards[index]),
                                      ],
                                    );
                                  })),
                            SizedBox(height: 64),
                            Container(
                              padding: EdgeInsets.only(left: appPadding, right: appPadding),
                              child: atIncomeAndOutcomeWidgetDB(totalIncome, totalOutcome),
                            ),
                            SizedBox(height: 64),
                            Row(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: appPadding, right: appPadding),
                                  child: percentIndicator()
                                ),
                                Spacer(),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(right: 28),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 64,
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(right: 8),
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF75CA92),
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      )),
                                                  Spacer(),
                                                  Container(
                                                    child:
                                                    Countup(
                                                      begin: 0,
                                                      end: percentIncomeTrans,
                                                      suffix: "%",
                                                      duration: Duration(milliseconds: 400),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'SFProText',
                                                        color: blackLight,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),                                                                                                               
                                                  ),                                                       
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              'Income',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'SFProText',
                                                color: grey8,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Container(
                                        padding: EdgeInsets.only(right: 28),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 64,
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(right: 8),
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFFC13C43),
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      )),
                                                  Spacer(),
                                                  Container(
                                                    child:
                                                    Countup(
                                                      begin: 0,
                                                      end: 100 - percentIncomeTrans,
                                                      suffix: "%",
                                                      duration: Duration(milliseconds: 400),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'SFProText',
                                                        color: blackLight,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),                                                                                                               
                                                  ),  
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              'Outcome',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'SFProText',
                                                color: grey8,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),                                              
                          ],
                        );
                      }
                    ),
                  ),  
                  onRefresh: () =>controlRefresh(),
                ),     
              ],
            ),
          ),
        ],
      ),
    );
  }

  getReexInfo() async {
    QuerySnapshot querySnapshot = await reexReference.get();
    reex.clear();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      Reex _reex = Reex();
      _reex = Reex.fromDocument(doc);
      reex.add(_reex);
    }
    QuerySnapshot querySnapshot2 = await transReference.get();
    trans.clear();
    for (int i = 0; i < querySnapshot2.docs.length; i++) {
      var doc = querySnapshot2.docs[i];
      Trans _trans = Trans();
      _trans = Trans.fromDocument(doc);
      trans.add(_trans);
    }
    //Get total income and outcome
    totalIncome = "0";
    totalOutcome = "0";
    for (int i = 0; i < reex.length; i++) {
      if (reex[i].type == "income") {
        totalIncome = (double.parse(totalIncome) + double.parse(reex[i].money)).toString();
      }
      else {
        totalOutcome = (double.parse(totalOutcome) + double.parse(reex[i].money)).toString();        
      }
    }
    // Get day, week, month, year revenue
    reDay = 0;
    reMonth = 0;
    reWeek = 0;
    reYear = 0;
    double inDay = 0;
    double inMonth = 0;
    double inWeek = 0;
    double inYear = 0;
    double outDay = 0;
    double outMonth = 0;
    double outWeek = 0;
    double outYear = 0;
    for (int i = 0; i < reex.length; i++) {
      if (reex[i].type == "income" && dayMonthYearOnly(reex[i].timestamp).compareTo(dayMonthYearOnly(DateTime.now())) == 0) {
        inDay = inDay + double.parse(reex[i].money);
      }
      if (reex[i].type == "outcome" && dayMonthYearOnly(reex[i].timestamp).compareTo(dayMonthYearOnly(DateTime.now())) == 0) {
        outDay = outDay + double.parse(reex[i].money);
      }
      if (reex[i].type == "income" 
      && reex[i].timestamp.month.compareTo(DateTime.now().month) == 0
      && reex[i].timestamp.year.compareTo(DateTime.now().year) == 0
      && reex[i].timestamp.weekOfMonth == DateTime.now().weekOfMonth) {
        inWeek = inWeek + double.parse(reex[i].money);
      }
      if (reex[i].type == "outcome" 
      && reex[i].timestamp.month.compareTo(DateTime.now().month) == 0
      && reex[i].timestamp.year.compareTo(DateTime.now().year) == 0
      && reex[i].timestamp.weekOfMonth == DateTime.now().weekOfMonth) {
        outWeek = outWeek + double.parse(reex[i].money);
      }      
      if (reex[i].type == "income" 
      && reex[i].timestamp.month.compareTo(DateTime.now().month) == 0
      && reex[i].timestamp.year.compareTo(DateTime.now().year) == 0) {
        inMonth = inMonth + double.parse(reex[i].money);
      }
      if (reex[i].type == "outcome" 
      && reex[i].timestamp.month.compareTo(DateTime.now().month) == 0
      && reex[i].timestamp.year.compareTo(DateTime.now().year) == 0) {
        outMonth = outMonth + double.parse(reex[i].money);
      }      
      if (reex[i].type == "income" 
      && reex[i].timestamp.year.compareTo(DateTime.now().year) == 0) {
        inYear = inYear + double.parse(reex[i].money);
      }
      if (reex[i].type == "outcome" 
      && reex[i].timestamp.year.compareTo(DateTime.now().year) == 0) {
        outYear = outYear + double.parse(reex[i].money);
      }                     
    }
    reDay = inDay - outDay;
    reWeek = inWeek - outWeek;
    reMonth = inMonth - outMonth;
    reYear = inYear - outYear;
    //Get transactions stuffs
    totalRevTrans = 0;
    percentIncomeTrans = 0;
    totalTrans = trans.length.toString();
    for (int i = 0; i < trans.length; i++) {
      if (trans[i].type == "order") {
        totalRevTrans = totalRevTrans + 1;
      }
    }
    percentIncomeTrans = double.parse(((totalRevTrans * 100) / double.parse(totalTrans)).toString());

    revenueCards.clear();
    revenueCards.add(atRevenueAndExpenditureCardWidget("Day", reDay, currentReexTime));
    revenueCards.add(atRevenueAndExpenditureCardWidget("Week", reWeek, currentReexTime));
    revenueCards.add(atRevenueAndExpenditureCardWidget("Month", reMonth, currentReexTime));
    revenueCards.add(atRevenueAndExpenditureCardWidget("Year", reYear, currentReexTime));          
  }

  DateTime dayMonthYearOnly(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  Future<void> controlRefresh() async {
    setState(() {
    });
  }

  percentIndicator() {
    return CircularPercentIndicator(
      radius: 160.0,
      lineWidth: 15.0,
      animation: true,
      animationDuration: 1000,
      percent: percentIncomeTrans / 100,
      center: Column(
        children: [
          SizedBox(height: 40),
          Countup(
            begin: 0,
            end: double.parse(totalTrans),
            duration: Duration(milliseconds: 400),
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'SFProText',
              color: blackLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Total ' + '\nTransactions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'SFProText',
              color: grey8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],          
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color(0xFF75CA92),
      backgroundColor: Color(0xFFC13C43),
      backgroundWidth: 15.0,
    );
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var wom = 0;
    var date = this;
    while (date.month == month) {
      wom++;
      date = date.subtract(const Duration(days: 7));
    }
    return wom;
  }
}  

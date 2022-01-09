import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/dialogWidget.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import models
import 'package:ui_fresh_app/models/drinkModel.dart';

//import views
import 'package:ui_fresh_app/views/account/profileManagement.dart';
import 'package:ui_fresh_app/views/bartender/dashboard/btSearchingDashboardManagement.dart';
import 'package:ui_fresh_app/views/bartender/dashboard/btCustomizeDrinkDetail.dart';
import 'package:ui_fresh_app/views/bartender/dashboard/btCreateDrinkDetail.dart';

//import others
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';

class btDashboardManagementScreen extends StatefulWidget {
  const btDashboardManagementScreen({Key? key}) : super(key: key);

  @override
  State<btDashboardManagementScreen> createState() =>
      _btDashboardManagementScreenState();
}

class _btDashboardManagementScreenState
    extends State<btDashboardManagementScreen>
    with SingleTickerProviderStateMixin {
  bool isHorizontal = false;
  TextEditingController searchController = TextEditingController();

  TabController? _tabController;
  int _selectedIndex = 0;
  double _currentPosition = 0.0;

  late PageController pageController;
  double viewportFraction = 0.554;
  double? pageOffset = 0;
  double? scale;

  List<Drink> drinksList = [];

  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _tabController != _tabController;
      });
      _selectedIndex = _tabController!.index;
      print(_selectedIndex);
    });

    _minpricecontroller.text = _lowerValue.toString();
    _maxpricecontroller.text = _upperValue.toString();

    pageController = new PageController(
        initialPage: 0, keepPage: true, viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = pageController.page;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        child: Scaffold(
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
                  children: [
                    SizedBox(height: 34 + appPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 28),
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      profileManagementScreen(),
                                ),
                              );
                              // .then((value) {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              width: 32,
                              child: displayAvatar(currentUser.avatar, 32, 32),
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
                            SizedBox(height: 1),
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
                          ],
                        ),
                        Spacer(),
                        Container(
                            // padding: EdgeInsets.only(right: 28),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                showFilter(context);
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color:
                                      (haveFilter == true) ? blackLight : white,
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
                                    child: Icon(Iconsax.setting_4,
                                        size: 18,
                                        color: (haveFilter == true)
                                            ? white
                                            : blackLight)),
                              ),
                            )),
                        SizedBox(width: 8),
                        Container(
                            // padding: EdgeInsets.only(right: 28),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        btCreateDrinkDetailScreen(),
                                  ),
                                );
                                // .then((value) {});
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
                                    child: Icon(Iconsax.add,
                                        size: 18, color: white)),
                              ),
                            )),
                        SizedBox(width: 28)
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 28, right: 28),
                          width: 280,
                          height: 40,
                          child: TextFormField(
                            controller: searchController,
                            autofocus: false,
                            onEditingComplete: () => controlSearchDrink(),
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: content14,
                                fontWeight: FontWeight.w400,
                                color: blackLight,
                                height: 1.4),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.search_normal_1,
                                size: 18,
                                color: black,
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 0),
                              hintText: "What are you looking for?",
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content14,
                                  fontWeight: FontWeight.w400,
                                  color: grey8,
                                  height: 1.4),
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 28),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.zero,
                            child: Text(
                              'Dashboard Menu',
                              style: TextStyle(
                                color: blackLight,
                                fontSize: title24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SFProText',
                              ),
                            ),
                          ),
                          Spacer(),
                          (isHorizontal == false)
                              ? Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isHorizontal = true;
                                      });
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
                                          child: Icon(Iconsax.slider_horizontal,
                                              size: 18, color: white)),
                                    ),
                                  ))
                              : Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isHorizontal = false;
                                        _currentPosition = 0.0;
                                        scale = viewportFraction;
                                      });
                                      // showFilter(context);
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
                                          child: Icon(Iconsax.element_3,
                                              size: 18, color: white)),
                                    ),
                                  )),
                          SizedBox(width: 28)
                        ]),
                    SizedBox(height: 32),
                    Container(
                      child: TabBar(
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: EdgeInsets.only(left: 28),
                        labelPadding: EdgeInsets.only(right: 16),
                        isScrollable: true,
                        onTap: (value) {
                          setState(() {
                            if (pageOffset == 1.0 ||
                                pageOffset == 2.0 ||
                                pageOffset == 3.0) {
                              setState(() {
                                _currentPosition = 0.0;
                                scale = viewportFraction;
                                _tabController != _tabController;
                              });
                            }
                          });
                        },
                        tabs: [
                          Container(
                            width: 80,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    (_selectedIndex == 0) ? blueWater : white),
                            alignment: Alignment.center,
                            child: Tab(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: 12,
                                    color:
                                        (_selectedIndex == 0) ? white : grey8,
                                    fontWeight: (_selectedIndex == 0)
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Tea',
                                    ),
                                    // TextSpan(
                                    //   text: ' 4',
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    (_selectedIndex == 1) ? blueWater : white),
                            alignment: Alignment.center,
                            child: Tab(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: 12,
                                    color:
                                        (_selectedIndex == 1) ? white : grey8,
                                    fontWeight: (_selectedIndex == 1)
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Juice',
                                    ),
                                    // TextSpan(
                                    //   text: ' 1',
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    (_selectedIndex == 2) ? blueWater : white),
                            alignment: Alignment.center,
                            child: Tab(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: 12,
                                    color:
                                        (_selectedIndex == 2) ? white : grey8,
                                    fontWeight: (_selectedIndex == 2)
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Beer',
                                    ),
                                    // TextSpan(
                                    //   text: ' 2',
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    (_selectedIndex == 3) ? blueWater : white),
                            alignment: Alignment.center,
                            child: Tab(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: 12,
                                    color:
                                        (_selectedIndex == 3) ? white : grey8,
                                    fontWeight: (_selectedIndex == 3)
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Wine',
                                    ),
                                    // TextSpan(
                                    //   text: ' 1',
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (isHorizontal == false)
                        ? Container(
                            // padding: EdgeInsets.zero,
                            width: double.maxFinite,
                            height: 512,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  _selectedIndex == 0 ? viewDrinksPerTab() : Container(), 
                                  _selectedIndex == 1 ? viewDrinksPerTab() : Container(), 
                                  _selectedIndex == 2 ? viewDrinksPerTab() : Container(), 
                                  _selectedIndex == 3 ? viewDrinksPerTab() : Container(), 
                                ]))
                        : Container(
                            padding: EdgeInsets.only(top: 32),
                            width: double.maxFinite,
                            height: 512,
                            child: 
                            TabBarView(
                                controller: _tabController,
                                children: [
                                  _selectedIndex == 0 ? viewDrinksPerTabHorizontal() : Container(),
                                  _selectedIndex == 1 ? viewDrinksPerTabHorizontal() : Container(),
                                  _selectedIndex == 2 ? viewDrinksPerTabHorizontal() : Container(),
                                  _selectedIndex == 3 ? viewDrinksPerTabHorizontal() : Container(),
                    ])),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  controlSearchDrink() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
    });
  }

  getAllDrinksSorted() async {
    await getAllDrinksInCategory();
    List<Drink> sortedList = [];
    for (int i = 0; i < drinksList.length; i++) {
      if (double.parse(drinksList[i].unit_price) >= double.parse(_minpricecontroller.text)
      && double.parse(drinksList[i].unit_price) <= double.parse(_maxpricecontroller.text)) {
        sortedList.add(drinksList[i]);
      }
    }
    drinksList.clear();
    drinksList = List.from(sortedList);
  }

  getAllDrinksSeached() async {
    await getAllDrinksInCategory();
    List<Drink> searchList = [];
    for (int i = 0; i < drinksList.length; i++) {
      if (drinksList[i].name.toLowerCase().
      contains(searchController.text.toLowerCase())) {
        searchList.add(drinksList[i]);
      }
    }
    drinksList.clear();
    drinksList = List.from(searchList);
  }

  getAllDrinksInCategory() async {
    String _selectedCategory = "";
    switch (_selectedIndex) {
      case 0:
        _selectedCategory = "Tea";
        break;
      case 1:
        _selectedCategory = "Juice";
        break;
      case 2:
        _selectedCategory = "Beer";
        break;
      case 3:
        _selectedCategory = "Wine";
        break;                    
    }    
    QuerySnapshot querySnapshot = await drinksReference.get();
    drinksList.clear();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      Drink drink = Drink();
      drink = Drink.fromDocument(doc);
      if (drink.category == _selectedCategory) {
        drinksList.add(drink);
      }
    }
    drinksList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    drinksList = drinksList.reversed.toList();  
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

  Future<void> controlRefresh() async {
    setState(() {
    });
  }

  viewDrinksPerTab() {
    return Container(
    padding:
        EdgeInsets.only(left: 28, right: 28),
    child: RefreshIndicator(
      onRefresh: () => controlRefresh(),
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
            child: Column(
          children: [
            FutureBuilder(
              future: searchController.text.isEmpty ? (haveFilter == true ? getAllDrinksSorted() : getAllDrinksInCategory()) : (haveFilter == true ? getAllDrinksSorted() : getAllDrinksSeached()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 30),
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
                return GridView.builder(
                padding: EdgeInsets.only(
                    top: 32, bottom: 120),
                physics:
                    NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (150 / 244),
                  crossAxisCount: 2,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 24,
                ),
                itemCount: drinksList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => controlSelectDrink(drinksList[index].id, drinksList[index].image, drinksList[index].name, drinksList[index].description, drinksList[index].unit_price),
                      child: Container(
                        width: 150,
                        height: 236,
                        child: Stack(children: [
                          Container(
                            width: 150,
                            height: 196,
                            margin:
                                EdgeInsets.only(
                                    top: 48),
                            padding:
                                EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    bottom: 16),
                            decoration: BoxDecoration(
                                color: blueLight,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            16)),
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .end,
                                children: [
                                  Container(
                                      alignment:
                                          Alignment
                                              .topLeft,
                                      child: Text(
                                        drinksList[index].name,
                                        style: TextStyle(
                                            fontSize:
                                                content16,
                                            fontFamily:
                                                'SFProText',
                                            color:
                                                blackLight,
                                            fontWeight: FontWeight
                                                .w600,
                                            height:
                                                1.4),
                                      )),
                                  SizedBox(
                                      height: 4),
                                  Container(
                                      width: 134,
                                      alignment:
                                          Alignment
                                              .centerLeft,
                                      padding:
                                          EdgeInsets
                                              .zero,
                                      child: Text(
                                        drinksList[index].description,
                                        maxLines:
                                            2,
                                        overflow:
                                            TextOverflow
                                                .ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                8,
                                            fontFamily:
                                                'SFProText',
                                            color:
                                                grey8,
                                            fontWeight: FontWeight
                                                .w400,
                                            height:
                                                1.4),
                                        textAlign:
                                            TextAlign
                                                .left,
                                      )),
                                  SizedBox(
                                      height: 8),
                                  Container(
                                      alignment:
                                          Alignment
                                              .topLeft,
                                      child: Text(
                                        "\$ " + drinksList[index].unit_price + ".00",
                                        style: TextStyle(
                                            fontSize:
                                                content16,
                                            fontFamily:
                                                'SFProText',
                                            color:
                                                blackLight,
                                            fontWeight: FontWeight
                                                .w600,
                                            height:
                                                1.4),
                                      )),
                                ]),
                          ),
                          Container(
                            width: 150,
                            height: 135,
                            alignment: Alignment.topCenter,
                            child: Container(
                              child: displayDrinkImage(drinksList[index].image, 220, 220),
                            ),
                          )
                        ]),
                      ));
                });
              }
            ),
          ],
        )),
      ),
    );  
  }

  viewDrinksPerTabHorizontal() {
    return RefreshIndicator(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: FutureBuilder(
              future: searchController.text.isEmpty ? (haveFilter == true ? getAllDrinksSorted() : getAllDrinksInCategory()) : (haveFilter == true ? getAllDrinksSorted() : getAllDrinksSeached()),
              builder: (context, _) {
                return PageView.builder(
                controller: pageController,
                onPageChanged: (num) {
                    if (num + 1 == 3) {
                      _currentPosition = 2.0;
                    } else if (num == 0) {
                      _currentPosition = 0.0;
                    } else {
                      _currentPosition =
                          num.toDouble();
                    }
                },
                scrollDirection: Axis.horizontal,
                itemCount: drinksList.length,
                itemBuilder: (context, index) {
                  double scale = max(
                      viewportFraction,
                      (1 -
                              (pageOffset! - index)
                                  .abs()) +
                          viewportFraction);
                  return GestureDetector(
                    onTap: () => controlSelectDrink(drinksList[index].id, drinksList[index].image, drinksList[index].name, drinksList[index].description, drinksList[index].unit_price),
                    child: Column(children: [
                      Container(
                        width: 160,
                        height: 196 + (scale * 50),
                        decoration: BoxDecoration(
                            color: blueLight,
                            borderRadius:
                                BorderRadius.circular(
                                    16)),
                        child: Center(
                          child: Container(
                            child: displayDrinkImage(drinksList[index].image, 200, 200),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      (_currentPosition == index)
                          ? Column(
                              children: [
                                Container(
                                    alignment:
                                        Alignment
                                            .center,
                                    child: Text(
                                          drinksList[index].name,
                                      style: TextStyle(
                                          fontSize:
                                              content18,
                                          fontFamily:
                                              'SFProText',
                                          color:
                                              blackLight,
                                          fontWeight:
                                              FontWeight
                                                  .w600,
                                          height:
                                              1.4),
                                    )),
                                SizedBox(height: 4),
                                Container(
                                    width: 160,
                                    alignment:
                                        Alignment
                                            .center,
                                    padding:
                                        EdgeInsets
                                            .zero,
                                    child: Text(
                                      drinksList[index].description,
                                      maxLines: 2,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontFamily:
                                              'SFProText',
                                          color:
                                              grey8,
                                          fontWeight:
                                              FontWeight
                                                  .w400,
                                          height:
                                              1.4),
                                      textAlign:
                                          TextAlign
                                              .center,
                                    )),
                                SizedBox(height: 8),
                                Container(
                                    alignment:
                                        Alignment
                                            .center,
                                    child: Text(
                                      "\$ " + drinksList[index].unit_price + ".00",
                                      style: TextStyle(
                                          fontSize:
                                              title24,
                                          fontFamily:
                                              'SFProText',
                                          color:
                                              blackLight,
                                          fontWeight:
                                              FontWeight
                                                  .w700,
                                          height:
                                              1.4),
                                    )),
                              ],
                            )
                          : Column()
                    ]),
                  );
                });
              }
            ),
          ),
        ],        
      ), 
      onRefresh: () => controlRefresh(),
    );
  }

controlSelectDrink(String _drinkID, String _drinkImageURL, String _drinkName, String _drinkDescription, String _drinkUnitPrice) async {
  var doc = await drinksReference.doc(_drinkID).get();
  if (doc.exists) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            btCustomizeDrinkDetailScreen(_drinkID, _drinkImageURL, _drinkName, _drinkDescription, _drinkUnitPrice),
      ),
    );
  }
  else {
    setState(() {
      showSnackBar(context, 'The drink has already been removed, please try another one!', 'error');      
    });
  }
}

  displayAvatar(String _url, double _height, double _width) => ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: CachedNetworkImage(
      imageUrl: _url,
      height: _height,
      width: _width,
      fit: BoxFit.cover,
      placeholder: (context, url) => 
        Center(child: CircularProgressIndicator()),
    ),
  );

  //Bottom Sheet - start

  TextEditingController _minpricecontroller = TextEditingController();
  TextEditingController _maxpricecontroller = TextEditingController();

  bool haveFilter = false;

  late DateTime selectDate1 = DateTime.now();
  late DateTime selectDate2 = DateTime.now();

  int selected = 0;
  double _lowerValue = 0;
  double _upperValue = 1000;

  FlutterSliderHandler customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: BoxDecoration(),
      child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 0.05,
                  blurRadius: 5,
                  offset: Offset(0, 1))
            ],
          ),
          child: Icon(Iconsax.coin, size: 20, color: blackLight)),
    );
  }

  showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 20,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter SetState1) {
          return Container(
            height: 685 - 96 - 104,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Image.asset(indicator),
                ),
                SizedBox(height: 24),
                Container(
                  child: Text(
                    'Refine Result',
                    style: TextStyle(
                      fontSize: title28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFProText',
                      color: blackLight,
                    ),
                  ),
                ),
                // SizedBox(height: 32),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(left: 28),
                //       child: Text(
                //         'Date',
                //         style: TextStyle(
                //             fontSize: content20,
                //             fontWeight: FontWeight.w600,
                //             fontFamily: 'SFProText',
                //             color: blackLight),
                //       ),
                //     ),
                //     Spacer(),
                //     Container(
                //       padding: EdgeInsets.only(right: 28, top: 0),
                //       child: Text(
                //         'range',
                //         style: TextStyle(
                //             fontSize: content16,
                //             fontWeight: FontWeight.w500,
                //             fontFamily: 'SFProText',
                //             color: grey8),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 16),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //         padding: EdgeInsets.only(left: 28),
                //         alignment: Alignment.centerLeft,
                //         child: GestureDetector(
                //           onTap: () async {
                //             String category = "reex";
                //             DateTime? dt = await datePickerDialog(
                //                 context, selectDate1, category);
                //             if (dt != null) {
                //               selectDate1 = dt;
                //               SetState1(() {
                //                 selectDate1 != selectDate1;
                //               });
                //             }
                //             print(selectDate1);
                //           },
                //           child: AnimatedContainer(
                //               alignment: Alignment.center,
                //               duration: Duration(milliseconds: 300),
                //               height: 36,
                //               width: 120,
                //               decoration: BoxDecoration(
                //                   color: white,
                //                   borderRadius: BorderRadius.circular(8),
                //                   border: Border(
                //                     top: BorderSide(width: 1, color: greyC),
                //                     left: BorderSide(width: 1, color: greyC),
                //                     right: BorderSide(width: 1, color: greyC),
                //                     bottom: BorderSide(width: 1, color: greyC),
                //                   )),
                //               child: Center(
                //                 child: Text(
                //                   // "12 November, 2021",
                //                   // dd/MM/yyyy
                //                   "${DateFormat('yMd').format(selectDate1)}",
                //                   // "${selectDate.day} ${selectDate.month}, ${selectDate.year}",
                //                   style: TextStyle(
                //                     color: blackLight,
                //                     fontFamily: 'SFProText',
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 16,
                //                   ),
                //                 ),
                //               )),
                //         )),
                //     Container(
                //         padding: EdgeInsets.zero,
                //         alignment: Alignment.center,
                //         child: Icon(Iconsax.arrow_right_1,
                //             size: 24, color: blackLight)),
                //     Container(
                //         padding: EdgeInsets.only(right: 28),
                //         alignment: Alignment.centerRight,
                //         child: GestureDetector(
                //           onTap: () async {
                //             String category = "reex";
                //             DateTime? dt = await datePickerDialog(
                //                 context, selectDate2, category);
                //             if (dt != null) {
                //               selectDate2 = dt;
                //               SetState1(() {
                //                 selectDate2 != selectDate2;
                //               });
                //             }
                //             print(selectDate2);
                //           },
                //           child: AnimatedContainer(
                //               alignment: Alignment.center,
                //               duration: Duration(milliseconds: 300),
                //               height: 36,
                //               width: 120,
                //               decoration: BoxDecoration(
                //                   color: white,
                //                   borderRadius: BorderRadius.circular(8),
                //                   border: Border(
                //                     top: BorderSide(width: 1, color: greyC),
                //                     left: BorderSide(width: 1, color: greyC),
                //                     right: BorderSide(width: 1, color: greyC),
                //                     bottom: BorderSide(width: 1, color: greyC),
                //                   )),
                //               child: Center(
                //                 child: Text(
                //                   // "12 November, 2021",
                //                   "${DateFormat('yMd').format(selectDate2)}",
                //                   // "${selectDate.day} ${selectDate.month}, ${selectDate.year}",
                //                   style: TextStyle(
                //                     color: blackLight,
                //                     fontFamily: 'SFProText',
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 16,
                //                   ),
                //                 ),
                //               )),
                //         )),
                //   ],
                // ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        'Price Range',
                        style: TextStyle(
                            fontSize: content20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SFProText',
                            color: blackLight),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 28),
                      child: Text(
                        'from',
                        style: TextStyle(
                            fontSize: content16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: grey8),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 164),
                      child: Text(
                        'to',
                        style: TextStyle(
                            fontSize: content16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProText',
                            color: grey8),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 28),
                        height: 36,
                        width: 148,
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: content16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFProText',
                                color: blackLight,
                                height: 0.8),
                            textAlign: TextAlign.center,
                            onChanged: (context) {
                              double min =
                                  double.parse(_minpricecontroller.text);
                              if (min <= _upperValue) {
                                _lowerValue = min;
                                print(_minpricecontroller.text);
                              }
                            },
                            onEditingComplete: () {
                              SetState1(() {
                                double min =
                                    double.parse(_minpricecontroller.text);
                                if (min <= _upperValue) {
                                  _lowerValue = min;
                                  print(_minpricecontroller.text);
                                } else {
                                  _lowerValue = 0;
                                  _minpricecontroller.text = "0.0";
                                  showSnackBar(context, "text", "error");
                                }
                              });
                            },
                            controller: _minpricecontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: greyC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixText: "\$",
                              prefixStyle: TextStyle(
                                fontSize: content16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFProText',
                                color: blackLight,
                              ),
                            )),
                      ),
                      Container(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          child: Icon(Iconsax.arrow_right_1,
                              size: 24, color: blackLight)),
                      Container(
                        padding: const EdgeInsets.only(right: 28),
                        height: 36,
                        width: 148,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: content16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SFProText',
                              color: blackLight,
                              height: 0.8),
                          textAlign: TextAlign.center,
                          onChanged: (context) {
                            double max = double.parse(_maxpricecontroller.text);
                            if (_lowerValue <= max) {
                              _upperValue = max;
                              print(_maxpricecontroller.text);
                            }
                          },
                          onEditingComplete: () {
                            SetState1(() {
                              double max =
                                  double.parse(_maxpricecontroller.text);
                              if (_lowerValue <= max) {
                                _upperValue = max;
                                print(_maxpricecontroller.text);
                              } else {
                                _maxpricecontroller.text = "1000.0";
                                _upperValue = 1000;
                                showSnackBar(context, "text", "error");
                              }
                            });
                          },
                          controller: _maxpricecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: greyC),
                                borderRadius: BorderRadius.circular(8)),
                            prefixText: "\$",
                            prefixStyle: TextStyle(
                              fontSize: content16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SFProText',
                              color: blackLight,
                            ),
                          ),
                        ),
                      ),
                    ]),
                SizedBox(height: 32),
                Container(
                  margin: EdgeInsets.only(left: 52, right: 52),
                  alignment: Alignment.centerLeft,
                  child: FlutterSlider(
                    values: [_lowerValue, _upperValue],
                    rangeSlider: true,
                    max: 1000,
                    min: 0,
                    step: FlutterSliderStep(step: 1),
                    jump: true,
                    trackBar: FlutterSliderTrackBar(
                      inactiveTrackBarHeight: 2,
                      activeTrackBarHeight: 3,
                    ),
                    disabled: false,
                    handler: customHandler(Icons.chevron_right),
                    rightHandler: customHandler(Icons.chevron_left),
                    tooltip: FlutterSliderTooltip(
                      leftPrefix: Icon(
                        Icons.attach_money,
                        size: 18,
                        color: blackLight,
                      ),
                      rightSuffix: Icon(
                        Icons.attach_money,
                        size: 18,
                        color: blackLight,
                      ),
                      textStyle: TextStyle(
                        fontSize: content16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SFProText',
                        color: blackLight,
                      ),
                    ),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      SetState1(() {
                        _lowerValue = lowerValue;
                        _upperValue = upperValue;
                        _minpricecontroller.text = lowerValue.toString();
                        _maxpricecontroller.text = upperValue.toString();
                      });
                    },
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: ElevatedButton(
                          onPressed: () {
                            if (double.parse(_minpricecontroller.text) <= double.parse(_maxpricecontroller.text)) {
                              setState(() {
                                haveFilter = true;
                              });
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              showSnackBar(
                                  context,
                                  'The max value must be greater than the min value.',
                                  "error");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(196, 52),
                            primary: Colors.black,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            ' Apply',
                            style: TextStyle(
                              fontSize: textButton20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SFProText',
                              color: white,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 28),
                      child: ElevatedButton(
                          onPressed: () {
                            SetState1(() {
                              _lowerValue = 0;
                              _upperValue = 1000;
                              _minpricecontroller.text = _lowerValue.toString();
                              _maxpricecontroller.text = _upperValue.toString();
                            });
                            setState(() {
                              haveFilter = false;
                            });
                            SetState1(() {
                              haveFilter = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(112, 52),
                            primary: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            ' Reset',
                            style: TextStyle(
                              fontSize: textButton20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SFProText',
                              color: blackLight,
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }
  // /Bottom Sheet - end
}

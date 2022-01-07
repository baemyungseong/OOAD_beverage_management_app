import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:ui_fresh_app/views/account/profileManagement.dart';

//import models
import 'package:ui_fresh_app/models/appUser.dart';

//import widgets
import 'package:ui_fresh_app/views/widget/dialogWidget.dart';
import 'package:ui_fresh_app/views/widget/snackBarWidget.dart';

//import views
import 'package:ui_fresh_app/views/storekeeper/user/skSearchingUser.dart';
import 'package:ui_fresh_app/views/storekeeper/user/skCreateNewAccount.dart';

//import others
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';

class skUserManagementScreen extends StatefulWidget {
  const skUserManagementScreen({Key? key}) : super(key: key);

  @override
  State<skUserManagementScreen> createState() => _skUserManagementScreenState();
}

class _skUserManagementScreenState extends State<skUserManagementScreen> {
  TextEditingController searchController = TextEditingController();

  List<appUser> accountsList = [];

  void initState() {
    super.initState();
    reSignIn();
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
              padding: EdgeInsets.only(
                  left: appPadding, top: appPadding, right: appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 34,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => profileManagementScreen(),
                              ),
                            );
                            // .then((value) {});
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentUser.name,
                            style: TextStyle(
                              fontSize: content16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SFProText',
                              color: blackLight,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                StringUtils.capitalize(currentUser.role),
                                style: TextStyle(
                                  fontSize: content10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SFProText',
                                  color: blackLight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        // padding: EdgeInsets.only(right: 28),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    skNewAccountCreatingScreen(),
                              ),
                            );
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
                              child: Icon(Iconsax.add, size: 18, color: white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 280,
                        height: 40,
                        child: TextFormField(
                          controller: searchController,
                          autofocus: false,
                          onEditingComplete: () => controlSearchUser(),
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
                            contentPadding: EdgeInsets.only(left: 20, right: 0),
                            hintText: "Who are you looking for?",
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
                  Text(
                    'Users Management',
                    style: TextStyle(
                      fontSize: title24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFProText',
                      color: blackLight,
                    ),
                  ),
                  SizedBox(height: 32),
                  loadAccounts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  controlSearchUser() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
    });
  }

  getAllAccountsSeached() async {
    await getAllAccounts();
    List<appUser> searchList = [];
    for (int i = 0; i < accountsList.length; i++) {
      if (searchController.text.toLowerCase() == accountsList[i].role.toLowerCase()) {
        searchList.add(accountsList[i]);
      }
      else if (accountsList[i].name.toLowerCase().
      contains(searchController.text.toLowerCase())) {
        searchList.add(accountsList[i]);
      }
    }
    accountsList.clear();
    accountsList = List.from(searchList);
  }
  

  getAllAccounts() async {
    accountsList.clear();
    QuerySnapshot querySnapshot = await userReference.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      appUser _user = appUser();
      _user = appUser.fromDocument(doc);
      if (_user.role != "storekeeper") {
        accountsList.add(_user);
      }
    }
    accountsList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    accountsList = accountsList.reversed.toList();    
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

  loadAccounts() {
    return Column(
      children: [
        Container(
          height: 598,
          width: 319,
          child: RefreshIndicator(
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),             
                child:
                FutureBuilder(
                  future: searchController.text.isEmpty ? getAllAccounts() : getAllAccountsSeached(),
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
                    return Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: accountsList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            onDismissed: (direction) => controlDeleteUser(accountsList[index].email, accountsList[index].encoded_pw, accountsList[index].key, accountsList[index].id),
                            direction: DismissDirection.endToStart,
                            key: ValueKey(index),
                            background: Container(
                              padding: EdgeInsets.only(right: 32),
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
                                    ]),
                              ),
                              child: Icon(Iconsax.minus, size: 24, color: white)),
                            child: GestureDetector(
                              onTap: () {
                                watchUserDialog(context, accountsList[index].name, accountsList[index].email, 
                                accountsList[index].phone_number, accountsList[index].dob, accountsList[index].avatar);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 24, top: 16, bottom: 16, right: 16),
                                decoration: BoxDecoration(
                                  color: blueLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 80,
                                width: 319,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          AnimatedContainer(
                                            alignment: Alignment.center,
                                            duration: Duration(milliseconds: 300),
                                            child: displayAvatar(accountsList[index].avatar, 48, 48),
                                          ),
                                          SizedBox(width: 24),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    accountsList[index].name,
                                                    style: TextStyle(
                                                      fontSize: content16,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'SFProText',
                                                      color: blackLight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Container(
                                                    height: 18,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      color: blueWater,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        StringUtils.capitalize(accountsList[index].role),
                                                        style: TextStyle(
                                                          fontFamily: 'SFProText',
                                                          fontSize: content8,
                                                          fontWeight: FontWeight.w500,
                                                          color: white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.sms,
                                                    color: blackLight,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    accountsList[index].email,
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontSize: content12,
                                                      fontWeight: FontWeight.w500,
                                                      color: grey8,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]
                                  ),
                                ),
                              )
                            );
                          },
                        ),
                        SizedBox(height: 112),
                      ],
                    );                            
                  },
                ), 
              ), 
            onRefresh: () => controlOnRefresh(),
          ),
        ),
      ],
    );    
  }

  Future<void> controlOnRefresh() async {
    setState(() {
    });
  }

  controlDeleteUser(String _email, String _encoded_pw, String _key, String _uid) async {
    PlatformStringCryptor cryptor;
    cryptor = PlatformStringCryptor();
    final salt = await cryptor.generateSalt();

    //Sign in the user
    var decoded_pw = await cryptor.decrypt(_encoded_pw, _key);
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: _email, password: decoded_pw);
      User? user = _firebaseAuth.currentUser;
      user!.delete().whenComplete(() => deleteAccountSuccessfully(_uid));
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      onFailureDeleteAccount();
    } catch(e) {
      onFailureDeleteAccount();
    }  
    reSignIn();
  }

  deleteAccountSuccessfully(String _uid) async {
    await userReference.doc(_uid).delete();
    showSnackBar(
        context,
        'Successfully removed the user!',
        'success');
    setState(() {
    });           
  }

  onFailureDeleteAccount() {
    showSnackBar(
        context,
        'Error occured! Please try again.',
        'error');
    setState(() {
    });             
  }



  reSignIn() async {
    PlatformStringCryptor cryptor;
    cryptor = PlatformStringCryptor();
    final salt = await cryptor.generateSalt();
    var decoded_pw_default = await cryptor.decrypt(currentUser.encoded_pw, currentUser.key);
    //Resignin the storekeeper
    firebaseAuth().signIn(currentUser.email, decoded_pw_default, context).then((val) async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
    });    
  }
}

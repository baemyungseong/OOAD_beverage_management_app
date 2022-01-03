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
  bool isUserDeleted = false;

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
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: blueWater,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://scontent.fsgn5-8.fna.fbcdn.net/v/t1.6435-9/50903697_2672799252747189_6623025456616570880_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=0debeb&_nc_ohc=TK2F5ekRXQ8AX8U_UKh&_nc_ht=scontent.fsgn5-8.fna&oh=00_AT9TXhfcm2xYO8PPao04FguuU-QFMshrwKndfcBZ9SjnAg&oe=61E61521'),
                                  fit: BoxFit.cover),
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
                            'Noob chảo',
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
                                'Accountant',
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
                          onEditingComplete: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => skUserSearchingScreen(
                                searchResult: searchController.text,
                              ),
                            ),
                          ),
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
                            hintText: "What're you looking for?",
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

  displayAvatar(String _url) => ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: CachedNetworkImage(
      imageUrl: _url,
      height: 48,
      width: 48,
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
          child: SingleChildScrollView(
            child:
            FutureBuilder(
              future: getAllAccounts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: 
                    CircularProgressIndicator(),
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
                                        child: displayAvatar(accountsList[index].avatar),
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
        ),
      ],
    );    
  }

  controlDeleteUser(String _email, String _encoded_pw, String _key, String _uid) async {
      PlatformStringCryptor cryptor;
      cryptor = PlatformStringCryptor();
      final salt = await cryptor.generateSalt();

      //Sign in the user
      var decoded_pw = await cryptor.decrypt(_encoded_pw, _key);
      firebaseAuth().signIn(_email, decoded_pw, context).then((val) async {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        user!.delete();
        await auth.signOut();
        isUserDeleted = true;
      });
      userReference.doc(_uid).delete();

      setState(() {
        reSignIn();
      });      
  }

/*
  reAuth() async {
    PlatformStringCryptor cryptor;
    cryptor = PlatformStringCryptor();
    final salt = await cryptor.generateSalt();
    //Reauth the storekeeper
    var decoded_pw_default = await cryptor.decrypt(currentUser.encoded_pw, currentUser.key);
    AuthCredential credential = EmailAuthProvider.credential(email: currentUser.email, password: decoded_pw_default);
    await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
  }
*/

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

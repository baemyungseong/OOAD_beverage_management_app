import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import constants
import 'package:ui_fresh_app/constants/colors.dart';
import 'package:ui_fresh_app/constants/fonts.dart';
import 'package:ui_fresh_app/constants/images.dart';
import 'package:ui_fresh_app/constants/others.dart';
import 'package:ui_fresh_app/views/bartender/inventory/btImportCreating.dart';

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

//import Firebase stuffs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_fresh_app/firebase/firestoreDocs.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ui_fresh_app/firebase/firebaseAuth.dart';

class btCreateDrinkDetailScreen extends StatefulWidget {
  btCreateDrinkDetailScreen({Key? key}) : super(key: key);

  @override
  _btCreateDrinkDetailScreenState createState() =>
      _btCreateDrinkDetailScreenState();
}

class _btCreateDrinkDetailScreenState
    extends State<btCreateDrinkDetailScreen> with InputValidationMixin {

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> priceFormKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    isTapDrinkType = false;
  }

  
  List<String> categories = ["Tea", "Juice", "Beer", "Wine"];
  var drinkTypes = [];
  String selectedCategory = "Tea";
  String selectedDrinkType = "";
  bool isTapDrinkType = false;
  var drinkImages = [];
  var drinkImageURL = "";

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
                          'Category',
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
                        child: Stack(
                          children: [
                            Container(
                              height: 48,
                              width: 319,
                              padding: EdgeInsets.only(left: 20, right: 12),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: blueLight
                              ),
                              child: Text(
                                selectedCategory,
                                style: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content14,
                                  fontWeight: FontWeight.w400,
                                  color: blackLight),                                
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 18),
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  key: UniqueKey(),
                                  iconColor: grey8,
                                  collapsedIconColor: black,
                                  title: Text(''),
                                  children: [
                                    SizedBox(height: 16),
                                    ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: categories.length,
                                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCategory = categories[index];
                                              isTapDrinkType = false;
                                            });
                                          },
                                          child: Container(
                                            height: 48,
                                            width: 319,
                                            padding: EdgeInsets.only(left: 20, right: 12),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: categories[index] == selectedCategory ? blueWater : blueLight,
                                            ),
                                            child: Text(
                                              categories[index],
                                              style: TextStyle(
                                                fontFamily: 'SFProText',
                                                fontSize: content14,
                                                fontWeight: FontWeight.w400,
                                                color: categories[index] == selectedCategory ? white : blackLight,
                                              ),                                
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],                                  
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: Text(
                          'Drink Type',
                          style: TextStyle(
                            fontFamily: "SFProText",
                            fontSize: 20.0,
                            color: blackLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      controlChooseDrinkType(),
                      SizedBox(height: 16),                                                                                                            
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
                                //validator
                                validator: (name) {
                                  if (isNameValid(name.toString())) {
                                    return null;
                                  } else {
                                    return '';
                                  }
                                },
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
                                //validator
                                validator: (description) {
                                  if (isDescriptionValid(description.toString())) {
                                    return null;
                                  } else {
                                    return '';
                                  }
                                },
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
                                keyboardType: TextInputType.number,
                                //validator
                                validator: (price) {
                                  if (isPriceValid(double.parse(price!))) {
                                    return null;
                                  } else {
                                    return '';
                                  }
                                },
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
                              if (nameFormKey.currentState!.validate() &&
                                  descriptionFormKey.currentState!.validate() &&
                                  priceFormKey.currentState!.validate()) {
                                controlAddNewDrink();    
                                Navigator.pop(context);
                                showSnackBar(context, 'The drink has been added successfully!', 'success');
                              } else {
                                showSnackBar(context, 'Please complete all information!', 'danger');
                              }
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
                  controlShowDrinkImage(),
                  SizedBox(height: 16),
                ]))
          ],
        )
      ])),
    );
  }

  controlGetDrinkImageCorrectly() async {
    await getDrinkImages();
    await getDrinkTypes();
    getCorrectImage();
  }

  controlShowDrinkImage() {
    return FutureBuilder(
      future: controlGetDrinkImageCorrectly(),
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
        return Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                  child: displayDrinkImage(drinkImageURL, 300, 300),
              ),
            ),
          ],
        );  
      }
    );
  }

  controlChooseDrinkType() {
    return FutureBuilder(
      future: getDrinkTypes(),
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
          child: Stack(
            children: [
              Container(
                height: 48,
                width: 319,
                padding: EdgeInsets.only(left: 20, right: 12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: blueLight
                ),
                child: Text(
                  selectedDrinkType,
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: content14,
                    fontWeight: FontWeight.w400,
                    color: blackLight),                                
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    key: UniqueKey(),
                    iconColor: grey8,
                    collapsedIconColor: black,
                    title: Text(''),
                    children: [
                      SizedBox(height: 16),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: drinkTypes.length,
                        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDrinkType = drinkTypes[index];
                                isTapDrinkType = true;
                              });
                            },
                            child: Container(
                              height: 48,
                              width: 319,
                              padding: EdgeInsets.only(left: 20, right: 12),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: drinkTypes[index] == selectedDrinkType ? blueWater : blueLight,
                              ),
                              child: Text(
                                drinkTypes[index],
                                style: TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: content14,
                                  fontWeight: FontWeight.w400,
                                  color: drinkTypes[index] == selectedDrinkType ? white : blackLight,
                                ),                                
                              ),
                            ),
                          );
                        },
                      ),
                    ],                                  
                  ),
                ),
              ),
            ],
          ),
        );    
      }                    
    );    
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

  getCorrectImage() {
    drinkImageURL = "";
    for (int i = 0; i < drinkImages.length; i++) {
      if (drinkImages[i].toString().contains(selectedDrinkType.replaceAll(" ", "%20"))) {
        drinkImageURL = drinkImages[i];
      }
    }
  }

  getDrinkImages() async {
    drinkImages.clear();
    firebase_storage.ListResult result = await teasReference.listAll();
    switch (selectedCategory) {
      case "Tea":
        result = await teasReference.listAll();
        break;
      case "Juice":
        result = await juicesReference.listAll();
        break;
      case "Beer":
        result = await beersReference.listAll();     
        break;
      case "Wine":
        result = await winesReference.listAll();      
        break;                                
    }

    result.items.forEach((firebase_storage.Reference ref) async {
      var drinkImg;
      drinkImg = await ref.getDownloadURL();
      drinkImages.add(drinkImg);
    });
  }

  getDrinkTypes() async {
    drinkTypes.clear();
    firebase_storage.ListResult result = await teasReference.listAll();
    switch (selectedCategory) {
      case "Tea":
        result = await teasReference.listAll();
        break;
      case "Juice":
        result = await juicesReference.listAll();
        break;
      case "Beer":
        result = await beersReference.listAll();     
        break;
      case "Wine":
        result = await winesReference.listAll();      
        break;                                
    }

    result.items.forEach((firebase_storage.Reference ref) async {
      var drinkType;
      drinkType = ref.toString();
      drinkType = pathImageToName(drinkType);
      drinkTypes.add(drinkType);
      isTapDrinkType == false ? selectedDrinkType = drinkTypes[0] : selectedDrinkType;
    });
  }

  String pathImageToName(String _path) {
    int startIndex = 0;
    switch (selectedCategory) {
      case "Tea":
        startIndex = 57;
        break;
      case "Juice":
        startIndex = 59;
        break;
      case "Beer":
        startIndex = 58;
        break;
      case "Wine":
        startIndex = 58;
        break;                                
    }
    return _path.substring(startIndex, _path.lastIndexOf('.'));
  }

  controlAddNewDrink() {
    drinksReference.add({
      "id": "",
      "category": selectedCategory,
      "name": nameController.text,
      "description": descriptionController.text,
      "unit price": priceController.text,
      "timestamp": DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()),
      "image": drinkImageURL,
    }).then(
      (DocumentReference docRef) => docRef.update({"id": docRef.id})
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

  bool isDescriptionValid(String name) => name.length >= 1;

  bool isPriceValid(double name) => name >= 0;

  // bool isPasswordValid(String password) => password.length >= 6;

  // bool isPhoneNumberValid(String phoneNumber) {
  //   RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  //   return regex.hasMatch(phoneNumber);
  // }
}

import 'dart:io';
import 'dart:math';

import 'package:TimePass/Model/userprofiles.dart';
import 'package:TimePass/tabs/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Navigation.dart';

class editprofile extends StatefulWidget {
  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  FirebaseAuth _auth;
  User user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _editname = TextEditingController();
  final TextEditingController _editbio = TextEditingController();
  final TextEditingController _editphone = TextEditingController();
  final TextEditingController _editcity = TextEditingController();
  final TextEditingController _editoccupation = TextEditingController();
  String test,
      EditName,
      EditBio,
      EditCity,
      EditOccupation,
      EditPhone,
      ImageUrl = "https://i.ibb.co/QdQ3CQK/undraw-wishes-icyp.png";
  userprofiles localuser;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Loader();
  }

  Widget Loader() {
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return loadingwidget();
        }
        return profilepage();
      },
    );
  }

  Widget profilepage() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {},
              child: ListView(
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: ImageUrl != null
                                  ? NetworkImage(localuser.Photo)
                                  : NetworkImage(
                                      localuser.Photo,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.green,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    uploadImage();
                                  },
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  // buildTextField("Full Name", localuser.Name, false),
                  // buildTextField("About", localuser.aboutus, false),
                  // buildTextField("Phone", localuser.phone, false),
                  // buildTextField("City", localuser.city, false),
                  // buildTextField("Occupation", localuser.occupation, false),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          EditName = value;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Name",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: localuser.Name,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      onChanged: (value) {
                        value == null
                            ? value = localuser.aboutus
                            : setState(() {
                                EditBio = value;
                              });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "About",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: localuser.aboutus,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 35.0),
                  //   child: TextFormField(
                  //     onChanged: (value) {
                  //       value == null
                  //           ? value = localuser.occupation
                  //           : setState(() {
                  //               EditCity = value;
                  //             });
                  //     },
                  //     decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.only(bottom: 3),
                  //         labelText: "City",
                  //         floatingLabelBehavior: FloatingLabelBehavior.always,
                  //         hintText: localuser.occupation,
                  //         hintStyle: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         )),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          EditPhone = value;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Phone",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: localuser.phone,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          EditOccupation = value;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Occupation",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: localuser.occupation,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            updatechanges();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Navigation()));
                          }
                        },
                        color: Color(0xFFEF5350),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  uploadImage() async {
    print('This Code Will Run');
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('UserProfilePhoto')
            .child(user.uid)
            .child(generateRandomString(200))
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          ImageUrl = downloadUrl;
        });
        FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'Photo': ImageUrl,
        });
        print(ImageUrl);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => editprofile()));
        // setState(() {});
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  updatechanges() async {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      'uid': user.uid,
      'aboutus': EditBio == null ? localuser.aboutus : EditBio,
      'Name': EditName == null ? localuser.Name : EditName,
      'phone': EditPhone == null ? localuser.phone : EditPhone,
      'occupation':
          EditOccupation == null ? localuser.occupation : EditOccupation,
    }).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigation()));
      Fluttertoast.showToast(
          msg: "Profile Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }).catchError((e) {
      print("GalatHoGaya");
    });
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 35.0),
    //   child: TextField(
    //     decoration: InputDecoration(
    //         suffixIcon: isPasswordTextField
    //             ? IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     // showPassword = !showPassword;
    //                   });
    //                 },
    //                 icon: Icon(
    //                   Icons.remove_red_eye,
    //                   color: Colors.grey,
    //                 ),
    //               )
    //             : null,
    //         contentPadding: EdgeInsets.only(bottom: 3),
    //         labelText: labelText,
    //         floatingLabelBehavior: FloatingLabelBehavior.always,
    //         hintText: placeholder,
    //         hintStyle: TextStyle(
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.black,
    //         )),
    //   ),
    // );
  }

  getCurrentUser() async {
    var user1 = FirebaseAuth.instance.currentUser;
    setState(() {
      user = user1;
    });
    final uid = user.uid;
    print(uid);
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    print(doc.data);

    setState(() {
      localuser = userprofiles.fromDocument(doc);
    });
    print(localuser.Email);
    print('this method has run');
  }
}

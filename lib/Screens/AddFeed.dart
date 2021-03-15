import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

import 'package:random_string/random_string.dart';

import '../Model/userprofile.dart';
import 'Navigation.dart';

class AddFeed extends StatefulWidget {
  @override
  _AddFeedState createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  String uid;
  String imageurl;

  String headfeed;
  FirebaseAuth _auth;
  User user;
  userprofile localuser;
  int docval;
  String bodyfeed;
  // userprofile localuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    getCurrentUser();
  }

  final TextEditingController heading = TextEditingController();
  final TextEditingController bodymaterial = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    heading.dispose();
    bodymaterial.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              // uploadImage();
              GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: Container(
                  child: imageurl != null
                      ? Image.network(imageurl)
                      : Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://classroomclipart.com/images/gallery/Clipart/Camera/TN_vector-camera-clipart.jpg'),
                              )),
                        ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 28),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.pink, width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextFormField(
                  maxLines: 5,
                  controller: heading,
                  decoration: InputDecoration(
                      // labelText: "Phone Number",
                      hintText: 'Add Caption......',
                      labelStyle: TextStyle(color: Colors.black87),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                  onChanged: (value) {
                    setState(() {
                      value = headfeed;
                    });
                  },
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(left: 10),
              //   height: 60,
              //   decoration: BoxDecoration(),
              //   margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              //   child: TextFormField(
              //     controller: heading,
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18,
              //     ),
              //     decoration: InputDecoration(
              //       hintStyle: TextStyle(
              //         color: Colors.black,
              //         fontSize: 18,
              //       ),
              //       hintText: 'Add heading',
              //       // border: InputBorder.none
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         value = headfeed;
              //       });
              //     },
              //   ),
              // ),
              SizedBox(
                height: 20.0,
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 10),
              //   height: 60,
              //   decoration: BoxDecoration(),
              //   margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              //   child: TextFormField(
              //     controller: bodymaterial,
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18,
              //     ),
              //     decoration: InputDecoration(
              //       hintStyle: TextStyle(
              //         color: Colors.black,
              //         fontSize: 18,
              //       ),
              //       hintText: 'Add Body',
              //       // border: InputBorder.none
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         value = bodyfeed;
              //       });
              //     },
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  // // uploadImage();
                  // FirebaseFirestore.instance.collection('Feed').add({
                  //   'Photo': imageurl,
                  //   'Head': heading.text,
                  //   'body': bodymaterial.text,
                  // });
                  // Fluttertoast.showToast(
                  //     msg: 'Song Uploaded Sucessfully',
                  //     timeInSecForIosWeb: 3,
                  //     gravity: ToastGravity.BOTTOM,
                  //     backgroundColor: Colors.pink,
                  //     textColor: Colors.white);
                  DialogBox(context, heading.text, bodymaterial.text, imageurl);
                },
                child: Container(
                  margin: EdgeInsets.all(30),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    // gradient: new LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomRight,
                    //   colors: [
                    //     // Color.fromARGB(255, 25, 178, 238),
                    //     Colors.red[400],
                    //     Colors.amber[600]
                    //   ],
                    // ),
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Add Feed',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  getuser() async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
    print(uid);
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
            .child('Feeds')
            .child(generateRandomString(200))
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageurl = downloadUrl;
        });
        // FirebaseFirestore.instance.collection('Feed').add({
        //   'Photo': imageurl,
        //   'Head': heading.text,
        //   'body': bodymaterial.text,
        // });

        print(imageurl);
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

  void DialogBox(context, name, author, String imageurl) {
    var baseDialog = AlertDialog(
      title: new Text("Upload"),
      content: Container(
        child: Text('Upload Feed'),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.blue,
          child: new Text("Confirm"),
          onPressed: () {
            print(heading.text);
            print(bodymaterial.text);

            print(imageurl);

            print(uid);

            if (heading.text != null &&
                // bodymaterial.text != null &&
                uid != null &&
                imageurl != null) {
              FirebaseFirestore.instance.collection('Feed').add({
                'UserPhoto': localuser.Photo,
                'UserName': localuser.Name,
                'Time': Timestamp.now().toDate().toString(),
                'uid': uid,
                'Photo': imageurl,
                'Head': heading.text,
                // 'body': bodymaterial.text,
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('PrivateCollection')
                    .doc(localuser.Name)
                    .collection(uid)
                    .add({
                  'UserPhoto': localuser.Photo,
                  'UserName': localuser.Name,
                  'Time': Timestamp.now().toDate().toString(),
                  'uid': uid,
                  'Photo': imageurl,
                  'Head': heading.text,
                  // 'body': bodymaterial.text,
                });

                Fluttertoast.showToast(
                    msg: 'Sucessfully Uploaded',
                    timeInSecForIosWeb: 3,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.pink,
                    textColor: Colors.white);
                Navigator.pop(context);
              });
            } else {
              Fluttertoast.showToast(
                  msg: 'Error Uploading',
                  timeInSecForIosWeb: 3,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.pink,
                  textColor: Colors.white);
            }

            // Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  getCurrentUser() async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyyyyyy");
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
      localuser = userprofile.fromDocument(doc);
    });
    print(localuser.Email);
    print('this method has run');
  }
}

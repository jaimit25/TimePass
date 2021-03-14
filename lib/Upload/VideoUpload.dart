import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoUpload extends StatefulWidget {
  @override
  _VideoUploadState createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  bool check = false;
  bool checkimage = false;

  File song;
  String Useruid;
  User user;
  String songurl;
  String imageurl;
  String songpath;
  TextEditingController _name = TextEditingController();
  TextEditingController _author = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    onWillPop() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Upload Video",
                      style: GoogleFonts.laila(
                          textStyle: TextStyle(
                              color: Colors.pink,
                              fontSize: 30,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectsong();
                  },
                  child: Container(
                    // color: Colors.black,
                    height: 180,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: check == true ? Colors.pink : Colors.yellow,
                      border: Border.all(color: Colors.blue, width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://cdn1.iconfinder.com/data/icons/hawcons/32/698931-icon-98-folder-upload-512.png"))),
                      ),
                    ),
                  ),
                ),
                TextFieldInput(_name, "Video Name"),
                TextFieldInput(_author, "Video Creater"),
                Container(
                  height: 50,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0)),
                    ),
                    onPressed: () {
                      // DialogBox(context, _name, _author);
                      uploadImage();
                    },
                    child: Text(
                      "Select Image",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: checkimage == true ? Colors.pink : Colors.blue,
                  ),
                ),
                Container(
                  height: 50,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        DialogBox(context, _name, _author);
                      },
                      child: Text(
                        "Add Video",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.pink),
                ),
                Center(
                  child: Text(
                    "Upload Video To The Video Submission",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: onWillPop);
  }

  void selectsong() async {
    print("ssssssssssssssssss");
    song = await FilePicker.getFile();

    setState(() {
      song = song;
      songpath = basename(song.path);

      uploadsongfile(song.readAsBytesSync(), songpath);
    });
  }

  Future<String> uploadsongfile(List<int> song, String songpath) async {
    var storage = FirebaseStorage.instance;
    var snap = await storage
        .ref()
        .child("Video")
        .child('Videos')
        .child(songpath)
        .putData(song);
    setState(() {
      check = true;
    });
    var downloadurl = await snap.ref.getDownloadURL();
    setState(() {
      songurl = downloadurl;
    });
    print(songurl + "xxxxxxxxxxxx");

    Fluttertoast.showToast(
        msg: 'Song Selected',
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }

  Widget TextFieldInput(TextEditingController controller, value) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(border: InputBorder.none, hintText: value),
      ),
    );
  }

  void DialogBox(context, name, author) {
    var baseDialog = AlertDialog(
      title: new Text("Upload"),
      content: Container(
        child: Text('Confirm Video Submission and Assuming it is Legal'),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.blue,
          child: new Text("Confirm"),
          onPressed: () {
            print(_name.text);
            print(_author.text);
            print(songurl);
            print(imageurl);

            if (_name != null &&
                _author != null &&
                songurl != null &&
                imageurl != null) {
              FirebaseFirestore.instance
                  .collection('Videos')
                  .doc(_name.text)
                  .set({
                // 'uid': Useruid,
                'Author': _author.text,
                'Name': _name.text,
                'url': songurl,
                'image': imageurl
              }).then((value) {
                Fluttertoast.showToast(
                    msg: 'Video Uploaded Sucessfully',
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

  // getCurrentUser() async {
  //   var user1 = FirebaseAuth.instance.currentUser;
  //   setState(() {
  //     user = user1;
  //   });
  //   final uid = user.uid;
  //   print(uid);
  //   setState(() {
  //     Useruid = uid;
  //   });
  //   print('this method has run');
  // }

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
            .child('Video')
            .child('VideoImage')
            .child(generateRandomString(200))
            .putFile(file);

        setState(() {
          checkimage = true;
        });

        var imgdownloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageurl = imgdownloadUrl;
        });

        print(imageurl);
        Fluttertoast.showToast(
            msg: 'Image Selected',
            timeInSecForIosWeb: 3,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.pink,
            textColor: Colors.white);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _author.dispose();
  }
}
// https://cdn1.iconfinder.com/data/icons/hawcons/32/698931-icon-98-folder-upload-512.png

import 'dart:async';

import 'package:TimePass/Authentication/Login.dart';
import 'package:TimePass/Screens/Navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/Model/userprofiles.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  var postnumber;
  FirebaseAuth _auth;
  User user;
  userprofiles localuser;
  int docval;
  @override
  QuerySnapshot searchResultSnapshot;
  bool check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    Timer(Duration(seconds: 3), () {
      // localuser.uid==
      print('this function will work');
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/janavi25preaload.appspot.com/o/TimePassNoText.png?alt=media&token=48743dbd-d1b3-447b-ac0b-56f35cadb7a7"),
      ),
    );
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
    print(localuser.Date);

    print('this method has run');
    //  var snapshots=await FirebaseFirestore.instance.collection('PrivateCollection').doc(localuser.Name).get();
    //  postnumber=snapshots.
    print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    // postnumber =
    //     await FirebaseFirestore.instance.collection('users').snapshots().length;
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('PrivateCollection')
        .doc(localuser.Name)
        .collection(await FirebaseAuth.instance.currentUser.uid)
        .get();
    int documents = qSnap.docs.length;
    setState(() {
      docval = documents;
    });
    print(documents);
  }
}

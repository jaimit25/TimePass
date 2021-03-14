import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/userprofile.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  var postnumber;
  FirebaseAuth _auth;
  User user;
  userprofile localuser;
  int docval;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getData();
    print(postnumber);
  }

  @override
  Widget build(BuildContext context) {
    return Loader();
  }

  getData() async {
    print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    // postnumber =
    //     await FirebaseFirestore.instance.collection('users').snapshots().length;
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('users').get();
    int documents = qSnap.docs.length;
    setState(() {
      docval = documents;
    });
    print(documents);
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

  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget profilepage() {
    return ListView(children: [
      Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.only(left: 20, top: 5),
                child: Icon(Icons.arrow_back_ios)),
            Container(
                margin: EdgeInsets.only(right: 20, top: 5),
                child: Icon(Icons.settings)),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5, top: 0),
        child: Column(
          children: [
            Container(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(localuser.Photo),
                            fit: BoxFit.cover)),
                    margin: EdgeInsets.only(left: 10, top: 10),
                  ),
                  Container(
                      height: 200,
                      margin: EdgeInsets.only(left: 20),
                      // width: 110,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20, top: 50),
                              child: Text(
                                localuser.Name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20, top: 5),
                              child: Text(
                                localuser.occupation,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 5),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.mail,
                                      color: Colors.pink,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(
                                      localuser.Email,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2, right: 5),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.pink,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text("+91" + localuser.phone),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 0, bottom: 10, left: 20),
        child: Text(
          "About",
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 3, bottom: 10, left: 20, right: 20),
        child: Text(
          localuser.aboutus,
          style: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Text(
                    '200',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Followers")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    '200',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Following")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30, top: 10, left: 10, bottom: 10),
              child: Column(
                children: [
                  Text(
                    "$docval",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Posts")
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 0),
        width: MediaQuery.of(context).size.width,
        height: 364,
        decoration: BoxDecoration(
          color: Colors.grey[600],
        ),
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.only(bottom: 1, top: 1),
          width: double.infinity,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, i) {
              return Container(
                  child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 1, right: 1, top: 1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 119,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            },
            itemCount: 200,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          ),
        ),
      )
    ]);
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
      localuser = userprofile.fromDocument(doc);
    });
    print(localuser.Email);
    print('this method has run');
  }
}

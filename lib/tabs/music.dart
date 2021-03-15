import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/Screens/tab_view_base.dart';
import 'package:TimePass/components/header.dart';
import 'package:TimePass/chat/Chat/search.dart';
import 'package:TimePass/Screens/AddFeed.dart';
import 'package:TimePass/chat tab/chat_pages.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/userprofiles.dart';

class music extends StatefulWidget {
  @override
  _musicState createState() => _musicState();
}

class _musicState extends State<music> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  var postnumber;
  FirebaseAuth _auth;
  User user;
  userprofiles localuser;
  int docval;
  @override
  QuerySnapshot searchResultSnapshot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              flexibleSpace: Header(
                'Timepasss',
                rightSide: Container(
                  height: 35.0,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  margin: EdgeInsets.only(right: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.forum,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            int checke;
                            checke = 2021 - localuser.Date;

                            if (checke > 13) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chatpages()));
                            } else {
                              DialogBox();
                            }
                          })),
                ),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Container(
                    height: 30.0,
                    child: Tab(
                      text: 'Home',
                    ),
                  ),
                  Container(
                    height: 30.0,
                    child: Tab(
                      text: 'Add Feed',
                    ),
                  ),
                ],
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey[400],
                indicatorWeight: 4.0,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.pink,
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                TabViewBase(
                  tabName: 'Breakfast',
                ),
                TabViewBase(
                  tabName: 'Lunch',
                ),
              ],
            ),
          ),
        ),
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

  getData() async {
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

  void DialogBox() {
    var baseDialog = AlertDialog(
      title: new Text("Restricted"),
      content: Container(
        child: Text('You are not Eligible to use this Feature'),
      ),
      actions: <Widget>[
        FlatButton(
            color: Colors.blue,
            child: new Text("okay"),
            onPressed: () {
              Navigator.pop(context);
            }
            // Navigator.pop(context);
            ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }
}

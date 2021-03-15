import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/userprofile.dart';

class globalchat extends StatefulWidget {
  @override
  _globalchatState createState() => _globalchatState();
}

class _globalchatState extends State<globalchat> {
  String useruid, comment;

  var Data;
  User user;

  TextEditingController _message = TextEditingController();
  FocusNode inputNode = FocusNode();
// to open keyboard call this function;
  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  userprofile localuser;
  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onWillPop() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xff0e8740),
          //   title: Text(
          //     'Global Chat',
          //     style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w700,
          //         color: Colors.white),
          //   ),
          //   actions: [
          //     // IconButton(
          //     //     icon: Icon(Icons.forward_rounded),
          //     //     onPressed: () {
          //     //       Navigator.of(context).pop();
          //     //       Navigator.push(context,
          //     //           MaterialPageRoute(builder: (context) => Navigation()));
          //     //     })
          //   ],
          // ),
          body: ListView(
            children: [
              StreamBuilder(
                  stream: Data,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: snapshot.data.docs.map((document) {
                          return Container(
                              child: Row(
                            children: [
                              // Container(
                              //     width: 200,
                              //     padding: EdgeInsets.all(8),
                              //     margin: EdgeInsets.all(5),
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey[300],
                              //       borderRadius: BorderRadius.circular(16),
                              //     ),
                              //     alignment: Alignment.center,
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           document['message'],
                              //           style: TextStyle(fontSize: 18),
                              //         ),
                              //         Text(
                              //           document['name'],
                              //           style: TextStyle(fontSize: 18),
                              //         ),
                              //       ],
                              //     )),
                              document['uid'] == localuser.uid
                                  ? Container(
                                      // color: Colors.black,
                                      //   with: 170,
                                      // margin: EdgeInsets.only(left: 270, right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: SizedBox(
                                              width: 30,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: rightside(document['name'],
                                                document['message']),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(right: 20),
                                      // width: MediaQuery.of(context).size.width,
                                      child: leftside(document['name'],
                                          document['message']),
                                    ),
                            ],
                          ));
                        }).toList());
                  }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Container(
              //       alignment: Alignment.bottomCenter,
              //       width: 260,
              //       padding: EdgeInsets.only(left: 10),
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.grey[300],
              //         borderRadius: BorderRadius.circular(16),
              //         border: Border.all(
              //           color: Colors.grey[50],
              //         ),
              //       ),
              //       margin:
              //           EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 5),
              //       child: TextFormField(
              //         controller: _message,
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18,
              //         ),
              //         decoration: InputDecoration(
              //             hintStyle: TextStyle(
              //               color: Colors.black38,
              //               fontSize: 18,
              //             ),
              //             hintText: 'Add Comment',
              //             border: InputBorder.none),
              //         onChanged: (value) {
              //           setState(() {
              //             comment = value;
              //           });
              //         },
              //       ),
              //     ),
              //     Container(
              //       margin:
              //           EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 5),
              //       child: IconButton(
              //           onPressed: () {
              //             if (!(_message.text == "")) {
              //               print("yyyyyyyyyyyyyyyyyyyyyyyyyyyy");
              //               FirebaseFirestore.instance
              //                   .collection('Chats')
              //                   .doc(Timestamp.now().toString())
              //                   .set({
              //                 'message': _message.text,
              //                 'name': localuser.Name,
              //                 'uid': localuser.uid
              //               }).then((value) {
              //                 _message.clear();
              //                 print(
              //                     "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\");
              //               }).catchError((e) {
              //                 print(e.toString());
              //               });
              //             } else {
              //               Fluttertoast.showToast(
              //                   msg: "Cannot send empty message",
              //                   timeInSecForIosWeb: 1,
              //                   graavity: ToastGravity.BOTTOM,
              //                   toastLength: Toast.LENGTH_LONG,
              //                   backgroundColor: Colors.red,
              //                   textColor: Colors.white);
              //             }
              //           },
              //           icon: Icon(
              //             Icons.send_outlined,
              //           )),
              //     )
              //   ],
              // ),
            ],
          ),
          floatingActionButton: Container(
            // width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            // color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  width: 260,
                  padding: EdgeInsets.only(left: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[50],
                    ),
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: TextFormField(
                    focusNode: inputNode,
                    autofocus: true,
                    controller: _message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 18,
                        ),
                        hintText: 'Type a message...',
                        border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                        comment = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, bottom: 0, right: 10, top: 5),
                  child: IconButton(
                      onPressed: () {
                        if (!(_message.text == "")) {
                          print("yyyyyyyyyyyyyyyyyyyyyyyyyyyy");
                          FirebaseFirestore.instance
                              .collection('Chats')
                              .doc(Timestamp.now().toString())
                              .set({
                            'message': _message.text,
                            'name': localuser.Name,
                            'uid': localuser.uid
                          }).then((value) {
                            _message.clear();
                            print(
                                "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\");
                          }).catchError((e) {
                            print(e.toString());
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Cannot send empty message",
                              timeInSecForIosWeb: 1,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        }
                      },
                      icon: Icon(
                        Icons.send_outlined,
                      )),
                )
              ],
            ),
          ),
        ),
        onWillPop: onWillPop);
  }

  getUser() async {
    user = FirebaseAuth.instance.currentUser;
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      useruid = user.uid;
      localuser = userprofile.fromDocument(doc);
    });

    print(useruid);
    Data = FirebaseFirestore.instance
        .collection('Chats')

        // .doc('usersfeed')
        // .collection('userimage')
        .snapshots();
    // final  Datacoll=FirebaseFirestore.instance
    //   .collection('Chats').
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  }

  Widget rightside(name, message) {
    return Container(
        alignment: Alignment.centerRight,
        // width: 200,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.pink[200],
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 5,
              ),
              child: Text(name,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  )),
            ),
            Container(
              width: 200,
              child: Text(message,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            )
          ],
        ));
  }

  Widget leftside(name, message) {
    return Container(
        margin: EdgeInsets.only(
          left: 10,
          top: 10,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.pink[500],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: 200,
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  )),
            ),
            Container(
              width: 200,
              child: Text(message,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            )
          ],
        ));
  }
}

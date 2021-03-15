import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/chat/Chat/database.dart';

import '../../Model/userprofile.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;

  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
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
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index]["message"],
                    sendByMe: localuser.Name ==
                        snapshot.data.documents[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": localuser.Name,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    onWillPop() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
        child: Scaffold(
          // appBar: appBarMain(context),
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text('Message '),
          ),
          body: Container(
            child: Stack(
              children: [
                chatMessages(),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    // color: Color(0x54FFFFFF),
                    color: Colors.pink,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 250,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border:
                                  Border.all(width: 0.5, color: Colors.black)),
                          child: Expanded(
                            child: TextField(
                              controller: messageEditingController,
                              // style: simpleTextStyle(),
                              decoration: InputDecoration(
                                  hintText: "Type Your Message..",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        // Expanded(
                        //     child: TextField(
                        //   controller: messageEditingController,
                        //   style: TextStyle(color: Colors.white, fontSize: 18),
                        //   decoration: InputDecoration(
                        //       hintText: "Message ",
                        //       hintStyle: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 16,
                        //       ),
                        //       border: InputBorder.none),
                        // )),
                        SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            addMessage();
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0x36FFFFFF),
                                      const Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: onWillPop);
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
    // final QuerySnapshot qSnap = await FirebaseFirestore.instance
    //     .collection('PrivateCollection')
    //     .doc(localuser.Name)
    //     .collection(await FirebaseAuth.instance.currentUser.uid)
    //     .get();
    // int documents = qSnap.docs.length;
    // setState(() {
    //   docval = documents;
    // });
    // print(documents);
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [Color(0xff007EF4), Color(0xff2A75BC)]
                  : [Colors.pink, Colors.pink],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/chat/Chat/database.dart';
import 'chat.dart';
import '../../Model/userprofile.dart';
import 'widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  var postnumber;
  FirebaseAuth _auth;
  User user;
  userprofile localuser;
  int docval;
  @override
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.docs[index]["Name"],
                searchResultSnapshot.docs[index]["Email"],
                searchResultSnapshot.docs[index]["Photo"],
              );
            })
        : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) {
    List<String> users = [localuser.Name, userName];

    String chatRoomId = getChatRoomId(localuser.Name, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                )));
  }

  Widget userTile(String userName, String userEmail, String Photo) {
    // return Container(
    //   color: Colors.pink,
    //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             userName,
    //             style: TextStyle(color: Colors.white, fontSize: 16),
    //           ),
    //           Text(
    //             userEmail,
    //             style: TextStyle(color: Colors.white, fontSize: 16),
    //           )
    //         ],
    //       ),
    //       GestureDetector(
    //         onTap: () {
    //           sendMessage(userName);
    //         },
    //         child: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //           decoration: BoxDecoration(
    //               color: Colors.blue, borderRadius: BorderRadius.circular(24)),
    //           child: Text(
    //             "Message",
    //             style: TextStyle(color: Colors.white, fontSize: 16),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Container(
        child: Column(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              sendMessage(userName);
            },
            child: Container(
              // color: Colors.pink,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),

                // color: Colors.pink
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.pink),
                        image: DecorationImage(
                            image: NetworkImage(Photo), fit: BoxFit.cover)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 200,
                          child: Text(
                            userEmail,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Divider(
            height: 5,
            color: Colors.black,
          ),
        )
      ],
    ));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    color: Colors.grey[50],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 250,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border:
                                  Border.all(width: 0.5, color: Colors.black)),
                          child: Expanded(
                            child: TextField(
                              controller: searchEditingController,
                              // style: simpleTextStyle(),
                              decoration: InputDecoration(
                                  hintText: "search username",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none),
                              onChanged: (String query) async {
                                // getCasesDetailList(query);

                                // if (query.isNotEmpty) {
                                //   setState(() {
                                //     isLoading = true;
                                //   });
                                //   await databaseMethods
                                //       .searchByNames(query)
                                //       .then((snapshot) {
                                //     searchResultSnapshot = snapshot;
                                //     print("$searchResultSnapshot");
                                //     setState(() {
                                //       isLoading = false;
                                //       haveUserSearched = true;
                                //     });
                                //   });
                                // }
                              },
                            ),
                          ),
                        ),
                        Divider(
                          height: 4,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            initiateSearch();
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0x36FFFFFF),
                                        const Color(0x0FFFFFFF)
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(12),
                              child: Icon(Icons.search)),
                        )
                      ],
                    ),
                  ),
                  userList(),
                ],
              ),
            ),
    );
  }

  // getCasesDetailList(query) async {
  //   return List<DocumentSnapshot> documentlist=(await FirebaseFirestore.instance
  //           .collection("users")
  //           .where("searchname", arrayContains: query)
  //           .get());
  //       .docs;
  // }

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

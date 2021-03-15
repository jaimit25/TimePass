import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/chat/Chat/chat.dart';
import '../../Model/userprofile.dart';
import 'database.dart';
import 'search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
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
    getUserInfogetChats();
  }

  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(localuser.Name, ""),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  getUserInfogetChats() async {
    // Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(localuser.Name).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${localuser.Name}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset(
        //   "assets/images/logo.png",
        //   height: 40,
        // ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          // GestureDetector(
          //   onTap: () {
          //     AuthService().signOut();
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => Authenticate()));
          //   },
          //   child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 16),
          //       child: Icon(Icons.exit_to_app)),
          // )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
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

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  // color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}

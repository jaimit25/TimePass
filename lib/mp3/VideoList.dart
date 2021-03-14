import 'package:TimePass/Media/music.dart';
// import 'package:TimePass/Screens/VideoApp.dart';
import 'package:TimePass/mp3/VideoApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  String useruid;
  var Data;
  User user;
  Colors like;
  bool likes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    // getData();
    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
    print(useruid);
    Data = FirebaseFirestore.instance
        .collection('Videos')
        // .doc('usersfeed')
        // .collection('userimage')
        .snapshots();
    print('ppppppppppppppppppppppppppp');
  }

  @override
  Widget build(BuildContext context) {
    onWillPop() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      body: WillPopScope(
        child: Container(
          child: StreamBuilder(
            stream: Data,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return ListTile(document['image'], document['url'],
                      document['Name'], document.id, document['Author']);
                }).toList(),
              );
            },
          ),
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  Widget ListTile(
      String image, String videourl, String name, String id, String writter) {
    return Container(
      height: 95,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 6, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffffffff),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey[300],
              blurRadius: 6.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          // 'https://i.pinimg.com/originals/fc/35/4c/fc354c09add7fdb57c4335dc91343d09.png',
                          image),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          writter,
                          style: TextStyle(fontSize: 13),
                        )),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideoApp(videourl)));
            },
            child: Container(
              height: 40,
              width: 80,
              // margin: EdgeInsets.only(left: 70),
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.pink,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Align(
                  alignment: Alignment
                      .center, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    "Play",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  getUser() async {
    Data = FirebaseFirestore.instance
        .collection('Videos')
        // .doc('usersfeed')
        // .collection('userimage')
        .snapshots();
    user = FirebaseAuth.instance.currentUser;

    setState(() {
      useruid = user.uid;
    });

    print(useruid);

    print(Data.toString());
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  }
}

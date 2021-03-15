import 'package:TimePass/Upload/SongUpload.dart';
import 'package:TimePass/Upload/VideoUpload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/Media/playlist.dart';
import 'package:google_fonts/google_fonts.dart';

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
}

class _feedState extends State<feed> {
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
        .collection('Feed')
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
                children: snapshot.data.docs.map<Widget>((document) {
                  // return Text(document['UserName']);
                  return FeedTile(
                      document['UserName'],
                      document['UserPhoto'],
                      document['Time'],
                      document['Head'],
                      document['Photo'],
                      document.id,
                      document['uid']);
                }).toList(),
              );
            },
          ),
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  getUser() async {
    Data = FirebaseFirestore.instance
        .collection('Feed')
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

  FeedTile(String name, String userImage, String time, String caption,
      String image, String id, String uid) {
    bool liked = false;

    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 10),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(140),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(140)),
                        height: 58,
                        width: 60,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                height: 78,
                                width: 74,
                                margin: const EdgeInsets.only(
                                    left: 0.0, right: 0, top: 0, bottom: 0),
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(140)),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    userImage,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 13),
                          child: Text(
                            name,
                            style: GoogleFonts.lato(
                                color: Colors.grey[700],
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            time.substring(0, 10),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                                color: Colors.grey[500],
                                fontSize: 15,
                                letterSpacing: 1,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ]),
                ],
              ),
              Container(
                height: 250,

                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 7.0,
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                ),

                // child: liked ? Liked(id, uid) : unLiked(id, uid),
                // child: Padding(
                //   padding:
                //       const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                //   child: Material(
                //       borderRadius: BorderRadius.all(Radius.circular(40)),
                //       elevation: 6,
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(10),
                //         ),
                //         child: Image.network(image),
                //       )),
                // ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Text(
                  caption,
                  maxLines: 10,
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 15,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 28.0),
                    child: Row(
                      children: [
                        Container(
                          //like icon
                          padding: const EdgeInsets.only(right: 5.0),

                          // child: Container(
                          //   child: Expanded(
                          //     child: StreamBuilder(
                          //       stream: FirebaseFirestore.instance
                          //           .collection('Feed')
                          //           .doc(id)
                          //           .collection('likes')
                          //           .where('uid', isEqualTo: uid)
                          //           .snapshots(),
                          //       // .snapshots(),
                          //       builder: (BuildContext context,
                          //           AsyncSnapshot<QuerySnapshot> snapshot) {
                          //         if (!snapshot.hasData) {
                          //           return Center(
                          //             child: CircularProgressIndicator(),
                          //           );
                          //         }
                          //         return Expanded(
                          //           child: ListView(
                          //             children: snapshot.data.docs
                          //                 .map<Widget>((document) {
                          //               // return Text(document['UserName']);
                          //               return Container(
                          //                 height: 30,
                          //                 child: document['like'] == 'like'
                          //                     ? Liked(id, uid)
                          //                     : unLiked(id, uid),
                          //               );
                          //             }).toList(),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),

                          // child: Image.network(
                          //   'https://images.vexels.com/media/users/3/157338/isolated/preview/4952c5bde17896bea3e8c16524cd5485-facebook-like-icon-by-vexels.png',
                          //   height: 30,
                          // ),
                        ),
                        // Text(
                        //   '45',
                        //   style: GoogleFonts.averageSans(
                        //       color: Colors.grey[700],
                        //       fontSize: 22,
                        //       letterSpacing: 1,
                        //       fontWeight: FontWeight.normal),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, right: 22.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 1.0),
                          child: Image.network(
                            'https://www.searchpng.com/wp-content/uploads/2019/02/Comment-Icon-PNG.png',
                            height: 40,
                          ),
                        ),
                        Text(
                          '45',
                          style: GoogleFonts.averageSans(
                              color: Colors.grey[700],
                              fontSize: 22,
                              letterSpacing: 1,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                child: Divider(
                  height: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Liked(docid, uid) {
    return Container(
        child: IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Feed')
                  .doc(docid)
                  .collection('likes')
                  .doc(uid)
                  .delete();
              // .set({'uid': uid, 'like': false});
            },
            icon: Icon(
              Icons.favorite_rounded,
              size: 26,
              color: Colors.pink,
            )));
  }

  Widget unLiked(docid, uid) {
    return Container(
        child: IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Feed')
                  .doc(docid)
                  .collection('likes')
                  .doc(uid)
                  .set({'uid': uid, 'like': true});
            },
            icon: Icon(
              Icons.favorite_border_outlined,
              size: 26,
              color: Colors.pink,
            )));
  }
}

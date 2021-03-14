import 'package:TimePass/Upload/SongUpload.dart';
import 'package:TimePass/Upload/VideoUpload.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/Media/playlist.dart';
import 'package:google_fonts/google_fonts.dart';

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
}

class _feedState extends State<feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
                                    'https://files.oyebesmartest.com/uploads/preview/insta-109011514-366lgstci.jpeg',
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
                            'Tanya Bansal',
                            style: GoogleFonts.lato(
                                color: Colors.grey[700],
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '1 hr',
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Text(
                  '“In the end we only regret the chances we didn’t take.”',
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 15,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    elevation: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                          'https://images.pexels.com/photos/1535244/pexels-photo-1535244.jpeg'),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 28.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.network(
                            'https://images.vexels.com/media/users/3/157338/isolated/preview/4952c5bde17896bea3e8c16524cd5485-facebook-like-icon-by-vexels.png',
                            height: 30,
                          ),
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
                                    'https://www.irreverentgent.com/wp-content/uploads/2018/03/Awesome-Profile-Pictures-for-Guys-look-away2.jpg',
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
                            'Aarav Ahuja',
                            style: GoogleFonts.lato(
                                color: Colors.grey[700],
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '1 hr',
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Text(
                  'There are moments that the words don’t reach.',
                  style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 15,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    elevation: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                          'https://images.unsplash.com/photo-1561569025-3171358211ec?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzh8fGNpdHklMjBza3l8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 28.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.network(
                            'https://images.vexels.com/media/users/3/157338/isolated/preview/4952c5bde17896bea3e8c16524cd5485-facebook-like-icon-by-vexels.png',
                            height: 30,
                          ),
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
            ],
          )
        ],
      ),
    );
  }
}

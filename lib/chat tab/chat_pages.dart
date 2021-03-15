import 'package:flutter/material.dart';
import 'package:TimePass/chat tab/tab_base.dart';
import 'package:TimePass/components/header.dart';
import 'package:TimePass/chat/Chat/search.dart';
import 'package:TimePass/Screens/AddFeed.dart';

class chatpages extends StatefulWidget {
  @override
  _chatpagesState createState() => _chatpagesState();
}

class _chatpagesState extends State<chatpages> {
  @override
  Widget build(BuildContext context) {
    onWillPop() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
        child: Container(
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
                    // rightSide: Container(
                    //   height: 35.0,
                    //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //   margin: EdgeInsets.only(right: 20.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.pink,
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    //   child: Center(
                    //       child: IconButton(
                    //           icon: Icon(
                    //             Icons.forum,
                    //             color: Colors.white,
                    //           ),
                    //           onPressed: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => Search()));
                    //           })),
                    // ),
                  ),
                  bottom: TabBar(
                    tabs: <Widget>[
                      Container(
                        height: 30.0,
                        child: Tab(
                          text: 'Private Chat',
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: Tab(
                          text: 'Global Chat',
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
                    tabbase(
                      tabName: 'Breakfast',
                    ),
                    tabbase(
                      tabName: 'Lunch',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: onWillPop);
  }
}

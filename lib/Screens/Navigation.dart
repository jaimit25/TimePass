import 'package:TimePass/Games/memory%20game/home.dart';
import 'package:TimePass/tabs/feed.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/tabs/music.dart';
import 'package:TimePass/tabs/profile.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentindex = 0;
  final tabs = [
    Center(
      child: music(),
    ),
    Center(
      child: feed(),
    ),
    Center(
      child: Home(),
    ),
    Center(
      child: profile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentindex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.grey[100],
          buttonBackgroundColor: Colors.red[400],
          items: [
            Icon(Icons.home),
            Icon(Icons.add_circle),
            Icon(Icons.gamepad_outlined),
            Icon(Icons.account_circle_outlined),
          ],
          onTap: (index) {
            setState(() {
              _currentindex = index;
            });
          }),
    );
  }
}

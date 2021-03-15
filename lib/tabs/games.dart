import 'package:TimePass/Games/memory%20game/home.dart';
import 'package:TimePass/Upload/SongUpload.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/Games/tictac/homepage.dart';

class games extends StatefulWidget {
  @override
  _gamesState createState() => _gamesState();
}

class _gamesState extends State<games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.ytimg.com/vi/qaCjBh7bWz0/maxresdefault.jpg"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:TimePass/Authentication/Login.dart';
import 'package:TimePass/Screens/Navigation.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      print('this function will work');
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/janavi25preaload.appspot.com/o/TimePassNoText.png?alt=media&token=48743dbd-d1b3-447b-ac0b-56f35cadb7a7"),
      ),
    );
  }
}

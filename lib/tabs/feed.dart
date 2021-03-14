import 'package:TimePass/Upload/SongUpload.dart';
import 'package:TimePass/Upload/VideoUpload.dart';
import 'package:flutter/material.dart';
import 'package:TimePass/Media/playlist.dart';

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
}

class _feedState extends State<feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: playlist(),
    );
  }
}

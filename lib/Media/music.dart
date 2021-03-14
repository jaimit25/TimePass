import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class music extends StatefulWidget {
  String url, name, aname, id, imgurl;
  music(this.url, this.name, this.aname, this.id, this.imgurl);
  @override
  _musicState createState() => _musicState(url, name, aname, id, imgurl);
}

class _musicState extends State<music> {
  String url, name, aname, id, imgurl;
  _musicState(this.url, this.name, this.aname, this.id, this.imgurl);
  double i = 0;
  var playerState;
  var duration;
  double _currentSliderValue = 20;
  var position;
  AudioPlayer audioPlugin = AudioPlayer();
  var _positionSubscription;
  bool _BtnIcon = false;

  @override
  Widget build(BuildContext context) {
    onwillpop() {
      Navigator.of(context).pop();
      audioPlugin.stop();
    }

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                height: 80,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 20, left: 40, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xffffffff),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Add to favourites",
                          style: TextStyle(fontSize: 13),
                        )),
                    Container(
                      height: 100,
                      width: 50,
                      margin: EdgeInsets.only(left: 70),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.pink,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Icon(
                        Icons.skip_next_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                width: double.infinity,
                margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          // 'https://i.pinimg.com/originals/fc/35/4c/fc354c09add7fdb57c4335dc91343d09.png',
                          imgurl == null
                              ? "https://i.pinimg.com/originals/fc/35/4c/fc354c09add7fdb57c4335dc91343d09.png"
                              : imgurl),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  name == null ? "Name" : name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.black54),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  aname == null ? "Singer" : aname,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(top: 20, right: 40),
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.pink,
                          borderRadius: BorderRadius.all(Radius.circular(70)),
                        ),
                        child: IconButton(
                            icon: Icon(
                              _BtnIcon ? Icons.pause : Icons.play_arrow,
                              size: 50,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_BtnIcon == true) {
                                  _BtnIcon = false;

                                  audioPlugin.pause();
                                } else {
                                  _BtnIcon = true;
                                  // audioPlugin.play("https://firebasestorage.googleapis.com/v0/b/janavi25preaload.appspot.com/o/Taylor%20Swift%20-%20Love%20Story_50k.mp3?alt=media&token=6a4e6578-e5dc-4e42-98c2-aa2dcc70197a");
                                  audioPlugin.play(url);

                                  _positionSubscription = audioPlugin
                                      .onAudioPositionChanged
                                      .listen((p) => setState(() {
                                            position = p;
                                            print(position.toString());
                                          }));
                                }
                              });
                            })),
                    GestureDetector(
                      onTap: () {
                        try {
                          audioPlugin.stop();

                          setState(() {
                            if (_BtnIcon == true) {
                              _BtnIcon = !_BtnIcon;
                            }
                          });
                        } catch (e) {
                          //Handle all other exceptions
                        }
                      },
                      child: Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(
                            top: 20,
                            right: 0,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey[400],
                                blurRadius: 6.0,
                              ),
                            ],
                            color: Colors.pink,
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                          ),
                          child: Icon(
                            Icons.stop,
                            size: 50,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: onwillpop);
  }
}

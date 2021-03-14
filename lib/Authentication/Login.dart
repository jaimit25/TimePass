import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/Navigation.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  List<Color> colors = [Color(0xFF330867), Color(0xFF30cfd0)];
  int _index = 0;
  var _passwordVisible = true;
  String email;
  String Nameuser;
  String password;
  FirebaseAuth auth;
  User user;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController _enroll_controller = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _phonenumber = new TextEditingController();

  TextEditingController _occupation = new TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _eController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset(
                //   'img/logobus.png',
                //   width: 220,
                //   height: 200,
                // ),
                Container(
                  child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/janavi25preaload.appspot.com/o/TimePassNoText.png?alt=media&token=48743dbd-d1b3-447b-ac0b-56f35cadb7a7"),
                  height: 190,
                  width: 190,
                ),
                Tabs(context),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 150),
                  firstChild: Login(context),
                  secondChild: SignUp(context),
                  crossFadeState: _index == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget Login(BuildContext context) {
    return Form(
      // key: formstate,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 15, right: 15, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _eController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.assignment_ind,
                                color: Colors.grey,
                              ),
                              labelText: "Email Id",
                              labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                        Divider(color: Colors.grey, height: 8),
                        TextFormField(
                          controller: _passController,
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  }),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 140,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _eController.text,
                                password: _passController.text)
                            .then((value) {
                          print('you clicked login');
                          // Navigator.of(context).pushReplacementNamed('/homepage');
                          print(
                              'XXXXXXXXXXXXX XXXXxxxxxxxxxxRxxxxSuccccccesfull xxxxxxxxxxxxxxxxxxXXXXXXXXXXXXXXXXXXXXXXXXX');
                          print('you clicked login button');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navigation()));
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: colors),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                              child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget SignUp(BuildContext context) {
    return Form(
      key: formstate,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Stack(
                overflow: Overflow.visible,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 15, right: 15, bottom: 20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(color: Colors.grey, height: 8),
                          TextFormField(
                            controller: _phonenumber,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                labelText: "Phone Number",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(color: Colors.grey, height: 8),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.grey,
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(color: Colors.grey, height: 8),
                          TextFormField(
                            controller: _occupation,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.featured_play_list,
                                  color: Colors.grey,
                                ),
                                labelText: "Occupation",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(color: Colors.grey, height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    }),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350,
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          print('you clicked Create Account button');
                          if (formstate.currentState.validate()) {
                            print("hiiiiiiiiiiiiiii" + _name.text);

                            // User user=await FirebaseAuth.instance
                            //     .createUserWithEmailAndPassword(
                            //         email: email, password: password)
                            //     .user;
                            User user = (await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text))
                                .user;
                            print('you clicked login');
                            // Email, Name, aboutus, uid, Photo, city, phone;
                            await FirebaseFirestore.instance
                                .collection('/users')
                                .doc(user.uid)
                                .set({
                              'uid': user.uid,
                              'Name': _name.text,
                              'Email': _emailController.text,
                              'phone': _phonenumber.text,
                              'aboutus':
                                  '\"You Know Yourself better\"...Tell About Yourself',
                              'occupation': _occupation.text,
                              'Photo':
                                  'https://www.pngitem.com/pimgs/m/294-2947257_interface-icons-user-avatar-profile-user-avatar-png.png'
                            }).then((result) {
                              print("User Added");
                            }).catchError((e) {
                              print("Error: $e" + "!");
                            });
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Navigation()));
                            // Navigator.of(context).pushReplacementNamed('/homepage');

                            // Navigator.of(context).pop();
                            // Navigator.of(context).pushNamed('/show');

                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: colors,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                                child: Text(
                              "SIGNUP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget Tabs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.12),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              _index == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Existing",
                          style: TextStyle(
                              color: _index == 0 ? Colors.black : Colors.white,
                              fontSize: 18,
                              fontWeight: _index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ))),
                  onTap: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              _index == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "New",
                          style: TextStyle(
                              color: _index == 1 ? Colors.black : Colors.white,
                              fontSize: 18,
                              fontWeight: _index == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ))),
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                ),
              )
            ],
          )),
    );
  }

  CreateUser() {}
}

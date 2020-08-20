import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/signup.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  bool _isloggedin = false;
  Map userProfile;
  // final facebookLogin = FacebookLogin();

//  _loginWithFacebook()async{
//
//    final result = await facebookLogin.logInWithReadPermissions(['email']);
//
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final token = result.accessToken.token;
//        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
//        final profile = JSON.jsonDecode(graphResponse.body);
//        print(profile+'******************');
//        setState(() {
//          userProfile = profile;
//          _isloggedin = true;
//        });
//        break;
//
//      case FacebookLoginStatus.cancelledByUser:
//        setState(() => _isloggedin = false );
//        break;
//      case FacebookLoginStatus.error:
//        setState(() => _isloggedin = false );
//        break;
//    }
//
//  }
//  _logout(){
//    facebookLogin.logOut();
//    setState(() {
//      _isloggedin = false;
//    });
//  }
  void clearSharedPerfs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('Exit Application?', style: TextStyle(color: grey)),
            content: Text('You are going to exit the application.',
                style: TextStyle(color: grey)),
            actions: <Widget>[
              FlatButton(
                child: Text('NO', style: TextStyle(color: grey)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES', style: TextStyle(color: grey)),
                onPressed: () {
                  SystemNavigator.pop();
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: primaryColor,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  'assets/images/cloud.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/location.svg',
                    width: 300,
                    height: 200,
                  ),
                ),
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 400.0, left: 35),
                      child: Text('PERSONAL',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 460, 0.0, 0.0),
                      child: Text('SAFETY',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.only(
                    top: 550, left: 40.0, bottom: 10, right: 40),
                child: Container(
                  height: 50.0,
                  width: 500,
                  child: RaisedButton(
                    color: greyFade,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 610, left: 40, right: 40, bottom: 0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    color: Color(0xff3b5995),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      //_loginWithFacebook;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: ImageIcon(
                            AssetImage(
                              'assets/images/photo.png',
                            ),
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Center(
                          child: Text(
                            'Login with Facebook ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 660.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              "SignUp",
                              style: TextStyle(color: Accent1),
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

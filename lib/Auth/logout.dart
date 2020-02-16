import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/signup.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: SvgPicture.asset(
                  'assets/images/location.svg',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 0.0, 0.0),
                    child: Text('PERSONAL',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(18.0, 65, 0.0, 0.0),
                    child: Text(' SAFTEY',
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
              padding: const EdgeInsets.only(left: 40.0, bottom: 10, right: 40),
              child: Container(
                height: 50.0,
                width: 500,
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: greyBorder,
                  color: greyFade,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 0),
              child: Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: greyBorder,
                  color: Color(0xff3b5995),
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      print('tapped');
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
            ),
            Center(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("New User ?",style: TextStyle(color: Colors.white),),
                  FlatButton(
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Accent1),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

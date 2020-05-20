import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/componants/color.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 190.0, left: 200),
              child: Container(
                width: 80,
                height: 80,
                child: SvgPicture.asset(
                  'assets/images/shine.svg',
                  color: grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/shield.svg',
                  color: grey,
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Account Created!",
                style: TextStyle(
                    color: grey, fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Make sure to confirm your email address from the Link sent to you before you attempt to Login!",
                style: TextStyle(
                  color: grey2,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 50.0,
                width: 250,
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: secondaryDark,
                  color: Accent1,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Logout()));
                    },
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

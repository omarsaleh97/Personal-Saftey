import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/componants/color.dart';

class Confirm extends StatefulWidget {
  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 30),
            child: Container(
              child: Text(
                "Forget Password",
                style: TextStyle(fontSize: 30, color: primaryColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 145, left: 30),
            child: Container(
              child: Text(
                "We've sent a verification link to ",
                style: TextStyle(fontSize: 17, color: grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 165, left: 30),
            child: Container(
              child: Text(
                "kkk@gmail.com",
                style: TextStyle(fontSize: 17, color: Accent1),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 195, left: 30),
              child: Text(
                "Tap the link in the email then tap continue.",
                style: TextStyle(fontSize: 17, color: grey),
              )),
          Padding(
            padding: const EdgeInsets.only(
                top: 260, left: 70.0, bottom: 10, right: 70),
            child: Container(
              height: 50.0,
              width: 300,
              child: RaisedButton(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewPassword()));
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {}
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
          Padding(
            padding: const EdgeInsets.only(
                top: 350, left: 70.0, bottom: 10, right: 70),
            child: Container(
              child: SvgPicture.asset(
                'assets/images/shield.svg',
                color: grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

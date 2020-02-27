import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';

class Confirm extends StatefulWidget {
  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 30),
              child: Container(
                child: Text(
                  "Confrim E-mail",
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
            Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 200, left: 20.0, right: 20.0),
                    child: Container(
                      height: displaySize(context).height * .07,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "Email",
                          labelStyle: TextStyle(
                              fontFamily: 'Ropoto',
                              fontWeight: FontWeight.bold,
                              color: greyIcon),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 270, left: 20.0, right: 20.0),
                    child: Container(
                      height: displaySize(context).height * .07,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "OTP",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 350, left: 70.0, bottom: 10, right: 70),
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
                  top: 400, left: 70.0, bottom: 10, right: 70),
              child: Container(
                child: SvgPicture.asset(
                  'assets/images/shield.svg',
                  color: grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

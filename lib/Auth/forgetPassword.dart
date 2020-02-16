import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/confirm.dart';
import 'package:personal_safety/componants/color.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
            padding: const EdgeInsets.only(top: 135, left: 30),
            child: Container(
              child: Text(
                "Enter your email that you signed up with",
                style: TextStyle(fontSize: 17, color: grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 155, left: 30),
            child: Container(
              child: Text(
                "then tap verify",
                style: TextStyle(fontSize: 17, color: Accent1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 185, left: 30),
            child: Form(
              key: _formKey,
              child: TextFormField(

                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: primaryColor,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                      fontFamily: 'Ropoto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
                onSaved: null,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return value.contains('@') ? null : 'Please use @ char .';
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 280, left: 70.0, bottom: 10, right: 70),
            child: Container(
              height: 50.0,
              width: 300,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: secondaryDark,
                color: primaryColor,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Confirm()));
                    }
                  },
                  child: Center(
                    child: Text(
                      'Verify',
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_safety/componants/card.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible;
  int nationalLength = 14;
  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: SingleChildScrollView(

          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: displaySize(context).height * .3,
                  width: displaySize(context).width * .6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: SvgPicture.asset(
                    'assets/images/location.svg',
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:20,left: 20,),
                        child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 85.0, left: 20.0, right: 20.0),
                        child: Container(
                          height: displaySize(context).height * .07,
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: "Full Name",
                              hintStyle: kHintStyle,
                            ),
                            onSaved: null,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your Name';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 155.0, left: 20.0, right: 20.0),
                        child: Container(
                          height: displaySize(context).height * .07,
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: kHintStyle,
                            ),
                            onSaved: null,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (value.isNotEmpty) {
                                return null;
                              }
                              return value.contains('@')
                                  ? null
                                  : 'Please use @ char .';
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 225.0, left: 20.0, right: 20.0),
                        child: Container(
                          height: displaySize(context).height * .07,
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                hintStyle: kHintStyle),
                            obscureText: passwordVisible,
                            onSaved: null,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 295.0, left: 20.0, right: 20.0),
                        child: Container(
                          height: displaySize(context).height * .07,
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: "National ID",
                              hintStyle: kHintStyle,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: passwordVisible,
                            onSaved: null,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your National ID number';
                              }
                              return value.length == 14
                                  ? null
                                  : 'Please make sure you entered 14 number !.';
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 365.0, left: 20.0, right: 20.0),
                        child: Container(
                          height: displaySize(context).height * .07,
                          decoration: kBoxDecorationStyle,
                          child: TextFormField(
                            style: new TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: "Phone Number",
                                hintStyle: kHintStyle),
                            onSaved: null,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your Phone Number';
                              }

                              return value.length == 11
                                  ? null
                                  : 'Please make sure you entered 11 number !.';
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 70.0, bottom: 10, right: 70),
                child: Container(
                  height: 50.0,
                  width: 200,
                  child: RaisedButton(
                    color: Accent1,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuccessCard()));
                      }
                    },
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

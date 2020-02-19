import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/success.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible;
  @override
  void initState() {
    passwordVisible = false;
  }

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
                "Choose a new password for your account.",
                style: TextStyle(fontSize: 17, color: grey),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 155, left: 20.0, right: 20.0),
                  child: Container(
                    height: displaySize(context).height * .07,
                    decoration: kBoxDecorationStyle,
                    child: TextFormField(
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        border: InputBorder.none,
                        labelText: "   Password",
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
                        labelStyle: TextStyle(
                            fontFamily: 'Ropoto',
                            fontWeight: FontWeight.bold,
                            color: greyIcon),
                      ),
                      obscureText: passwordVisible,
                      onSaved: null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '   Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 220.0, left: 20.0, right: 20.0),
            child: Container(
              height: displaySize(context).height * .07,
              decoration: kBoxDecorationStyle,
              child: TextFormField(
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  labelText: "   Repeat password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  labelStyle: TextStyle(
                      fontFamily: 'Ropoto',
                      fontWeight: FontWeight.bold,
                      color: greyIcon),
                ),
                obscureText: passwordVisible,
                onSaved: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return '   Please enter your password';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 300, left: 70.0, bottom: 10, right: 70),
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
                          MaterialPageRoute(builder: (context) => Success()));
                    }
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
          Padding(
            padding: const EdgeInsets.only(
                top: 450, left: 70.0, bottom: 10, right: 70),
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

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
  TextEditingController _loginController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();


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
            padding: const EdgeInsets.only(top: 145, left: 30),
            child: Container(
              child: Text(
                "Choose a new password for your account.",
                style: TextStyle(fontSize: 17, color: grey),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 175, left: 20.0, right: 20.0),
                  child: Container(
                    height: displaySize(context).height * .07,
                    decoration: kBoxDecorationStyle2,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _loginController,
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Email",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 250.0, left: 20.0, right: 20.0),
                  child: Container(
                    decoration: kBoxDecorationStyle2,
                    child: TextField(
                      controller: _tokenController,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Code here",
                        errorBorder: InputBorder.none,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 325, left: 20.0, right: 20.0),
                  child: Container(
                    height: displaySize(context).height * .07,
                    decoration: kBoxDecorationStyle2,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "New Password",
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

                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
            child: Container(
              height: displaySize(context).height * .07,
              decoration: kBoxDecorationStyle2,
              child: TextField(
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Repeat password",
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
                ),
                obscureText: passwordVisible,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 470, left: 70.0, bottom: 10, right: 70),
            child: Container(
              height: 50.0,
              width: 300,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: primaryColor,
                child: RaisedButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                     ),
                  onPressed: () {
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
                top: 470, left: 70.0, bottom: 10, right: 70),
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

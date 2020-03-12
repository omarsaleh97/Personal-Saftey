import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/Auth/Confirm_newEmail.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/success.dart';
import 'package:personal_safety/componants/card.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';
import 'package:personal_safety/models/register.dart';
import 'package:personal_safety/services/service_register.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegisterService get registerService => GetIt.instance<RegisterService>();
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  bool _isLoading = false;
  bool passwordVisible;
  bool fullNameFlag = false;
  bool emailFlag = false;
  bool passwordFlag = false;
  bool nationalIDFlag = false;
  bool phoneNumberFlag = false;
  String errorMessages;
  RegisterCredentials register;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nationalIdController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  int nationalLength = 14;

  @override
  void initState() {
    _isLoading = false;

    passwordVisible = false;
  }

  nameValidation() {
    if (_fullNameController.text.isEmpty) {
      fullNameFlag = false;
    } else
      fullNameFlag = true;
  }

  emailValidation() {
    if (!_emailController.text.trim().toLowerCase().contains('@')) {
      emailFlag = false;
    } else if (_emailController.text.isEmpty) {
      emailFlag = false;
    } else
      emailFlag = true;
  }

  passwordValidation() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    passwordFlag = regExp.hasMatch(_passwordController.text);
  }

  nationalIDValidation() {
    if (_nationalIdController.text.trim().length < 14) {
      nationalIDFlag = false;
    } else if (_emailController.text.isEmpty) {
      nationalIDFlag = false;
    } else
      nationalIDFlag = true;
  }

  phoneValidation() {
    if (_phoneNumberController.text.trim().length < 11) {
      phoneNumberFlag = false;
    } else if (_phoneNumberController.text.isEmpty) {
      phoneNumberFlag = false;
    } else
      phoneNumberFlag = true;
  }

  ShowDialog(String title, String text) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Container(
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
                      child: Form(key: _formKey, child: SignupForm()),
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
                          onPressed: () async {
                            nameValidation();
                            passwordValidation();
                            emailValidation();
                            nationalIDValidation();
                            phoneValidation();
                            if (fullNameFlag == true &&
                                emailFlag == true &&
                                passwordFlag == true &&
                                nationalIDFlag == true &&
                                phoneNumberFlag == true) {
                              setState(() async {
                                setState(() {
                                  _isLoading = true;
                                });

                                final register = RegisterCredentials(
                                  fullName: _fullNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  nationalId: _nationalIdController.text,
                                  phoneNumber: _phoneNumberController.text,
                                );
                                final result =
                                    await registerService.Register(register);
                                debugPrint("from REGISTER status: " +
                                    result.status.toString());
                                debugPrint("from REGISTER token : " +
                                    result.result.toString());
                                debugPrint("from REGISTER error : " +
                                    result.hasErrors.toString());
                                final title = result.hasErrors
                                    ? 'Error'
                                    : 'Registration Successful!';
                                final text = result.hasErrors
                                    ? 'Make sure that Email, Phone Number and National ID are not taken.'
                                    : 'Account Created Successfully!';
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text(title),
                                          content: Text(text),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  Navigator.of(context).pop();
                                                })
                                          ],
                                        )).then((data) {
                                  if (result.status == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Success()));
                                  }
                                });
                              });
                            } else if (fullNameFlag == false)
                              ShowDialog("Error", "Name can't be empty.");
                            else if (emailFlag == false)
                              ShowDialog("Error", "Invalid Email Address");
                            else if (passwordFlag == false)
                              ShowDialog("Error",
                                  "Password be longer than 6 characters and must contain 1 Uppercase letter, 1 Number and 1 Special character.");
                            else if (nationalIDFlag == false)
                              ShowDialog(
                                  "Error", "National ID must be 14 digits.");
                            else if (phoneNumberFlag == false)
                              ShowDialog(
                                  "Error", "Phone Number must be 11 digits.");
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
            );
          },
        ),
      ),
    );
  }

  SignupForm() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
          ),
          child: Text(
            "SignUp",
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 85.0, left: 20.0, right: 20.0),
          child: Container(
            height: displaySize(context).height * .07,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _fullNameController,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                contentPadding: const EdgeInsets.all(20),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "Full Name",
                hintStyle: kHintStyle,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 155.0, left: 20.0, right: 20.0),
          child: Container(
            height: displaySize(context).height * .07,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                errorText: _validate ? emailValidation() : null,
                contentPadding: const EdgeInsets.all(20),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "Email",
                hintStyle: kHintStyle,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 225.0, left: 20.0, right: 20.0),
          child: Container(
            height: displaySize(context).height * .07,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  errorText: _validate ? passwordValidation() : null,
                  contentPadding: const EdgeInsets.all(20),
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Password",
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
                  hintStyle: kHintStyle),
              obscureText: passwordVisible,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 295.0, left: 20.0, right: 20.0),
          child: Container(
            height: displaySize(context).height * .07,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _nationalIdController,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                errorText: _validate ? nationalIDValidation() : null,
                contentPadding: const EdgeInsets.all(20),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "National ID",
                hintStyle: kHintStyle,
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
          padding: EdgeInsets.only(top: 365.0, left: 20.0, right: 20.0),
          child: Container(
            height: displaySize(context).height * .07,
            decoration: kBoxDecorationStyle,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  errorText: _validate ? phoneValidation() : null,
                  contentPadding: const EdgeInsets.all(20),
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Phone Number",
                  hintStyle: kHintStyle),
            ),
          ),
        ),
      ],
    );
  }
}

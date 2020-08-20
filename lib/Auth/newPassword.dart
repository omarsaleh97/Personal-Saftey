import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/Auth/success.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';
import 'package:personal_safety/models/change_password.dart';
import 'package:personal_safety/services/change_password_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool passwordInvisible;
  bool oldPasswordFlag = false;
  bool newPasswordFlag = false;
  bool confirmPasswordFlag = false;
  bool _isLoading = false;

  ChangePasswordService get userService =>
      GetIt.instance<ChangePasswordService>();
  @override
  void initState() {
    passwordInvisible = false;
  }

  passwordValidation() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    oldPasswordFlag = regExp.hasMatch(_oldPasswordController.text);
    newPasswordFlag = regExp.hasMatch(_newPasswordController.text);
    confirmPasswordFlag = regExp.hasMatch(_confirmPasswordController.text);
    if (_newPasswordController.text == _oldPasswordController.text) {
      newPasswordFlag = false;
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      confirmPasswordFlag = false;
    }
  }

  ShowDialog(String title, String text) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text(
                title,
                style: TextStyle(color: grey),
              ),
              content: Text(text, style: TextStyle(color: grey)),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK', style: TextStyle(color: grey)),
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
        body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Builder(
              builder: (_) {
                if (_isLoading) {
                  return Center(
                      child: CustomLoadingIndicator(
                    customColor: primaryColor,
                  ));
                }
                return SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 100, left: 30),
                        child: Container(
                          child: Text(
                            "Change Password",
                            style: TextStyle(fontSize: 30, color: primaryColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 145, left: 30),
                        child: Container(
                          child: Text(
                            "Input your old password, followed by your New Password twice.",
                            style: TextStyle(fontSize: 17, color: grey),
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 250.0, left: 20.0, right: 20.0),
                              child: Container(
                                decoration: kBoxDecorationStyle2,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: new TextStyle(color: Colors.black),
                                  controller: _oldPasswordController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "Old Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        passwordInvisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          passwordInvisible =
                                              !passwordInvisible;
                                        });
                                      },
                                    ),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Ropoto',
                                        fontWeight: FontWeight.bold,
                                        color: greyIcon),
                                  ),
                                  obscureText: passwordInvisible,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 325, left: 20.0, right: 20.0),
                              child: Container(
                                height: displaySize(context).height * .07,
                                decoration: kBoxDecorationStyle2,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: new TextStyle(color: Colors.black),
                                  controller: _newPasswordController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "New Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        passwordInvisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          passwordInvisible =
                                              !passwordInvisible;
                                        });
                                      },
                                    ),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Ropoto',
                                        fontWeight: FontWeight.bold,
                                        color: greyIcon),
                                  ),
                                  obscureText: passwordInvisible,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 400.0, left: 20.0, right: 20.0),
                        child: Container(
                          height: displaySize(context).height * .07,
                          decoration: kBoxDecorationStyle2,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            style: new TextStyle(color: Colors.black),
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              errorBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: "Confrim Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  passwordInvisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    passwordInvisible = !passwordInvisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: passwordInvisible,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 500, left: 70.0, bottom: 10, right: 70),
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
                                passwordValidation();
                                if (oldPasswordFlag == true &&
                                    newPasswordFlag == true &&
                                    confirmPasswordFlag == true)
                                  setState(() async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    final changePassword =
                                        ChangePasswordCredentials(
                                      oldPassword: _oldPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                    );
                                    final result = await userService
                                        .changePassword(changePassword);
                                    debugPrint("from Change Password: " +
                                        result.status.toString());
                                    debugPrint("from Change Password: " +
                                        result.result.toString());
                                    debugPrint("from Change Password: " +
                                        result.hasErrors.toString());
                                    final title = result.status == 0
                                        ? 'Your Password is Changed'
                                        : 'Error';
                                    final text = result.status == 0
                                        ? 'Please login once again.'
                                        : "Your Old Password is incorrect.";
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              title: Text(
                                                title,
                                                style: TextStyle(color: grey),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(height: 20),
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    child: SvgPicture.asset(
                                                      'assets/images/shine.svg',
                                                      color: grey,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: SvgPicture.asset(
                                                      'assets/images/shield.svg',
                                                      color: grey,
                                                      height: 100,
                                                    ),
                                                  ),
                                                  SizedBox(height: 30),
                                                  Text(
                                                    text,
                                                    style:
                                                        TextStyle(color: grey),
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    child: Text('OK',
                                                        style: TextStyle(
                                                            color: grey)),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                              ],
                                            )).then((data) {
                                      if (result.status == 0) {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Logout()));
                                      }
                                    });
                                  });
                                else if (oldPasswordFlag == false)
                                  ShowDialog("Wrong Password",
                                      "Your old password is incorrect.");
                                else if (newPasswordFlag == false)
                                  ShowDialog(
                                      "Something is wrong with the New Password.",
                                      "Password must: \n-Not match your Old Password.\n-Be longer than 7 characters.\n-Contain 1 Uppercase letter.\n-Contain 1 Number.\n-Contain 1 Special character.");
                                else if (confirmPasswordFlag == false)
                                  ShowDialog("Error",
                                      "Both New Password fields don't match.");
                              },
                              child: Center(
                                child: Text(
                                  'Change Password',
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
                );
              },
            )));
  }
}

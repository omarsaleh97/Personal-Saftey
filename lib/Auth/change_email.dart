import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/Auth/success.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';
import 'package:personal_safety/services/change_email_service.dart';
import 'package:personal_safety/services/change_password_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oldEmailController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _confirmEmailController = TextEditingController();

  bool oldEmailFlag = false;
  bool newEmailFlag = false;
  bool confirmEmailFlag = false;
  bool _isLoading = false;

  ChangeEmailService get userService => GetIt.instance<ChangeEmailService>();
  @override
  void initState() {}
  emailValidation() {
    if (!_oldEmailController.text.trim().toLowerCase().contains('@')) {
      oldEmailFlag = false;
    } else if (_oldEmailController.text.isEmpty) {
      oldEmailFlag = false;
    } else
      oldEmailFlag = true;
    if (!_newEmailController.text.trim().toLowerCase().contains('@')) {
      newEmailFlag = false;
    } else
      newEmailFlag = true;
    if (_newEmailController.text == _oldEmailController.text) {
      newEmailFlag = false;
    } else if (_newEmailController.text != _confirmEmailController.text) {
      confirmEmailFlag = false;
    } else
      confirmEmailFlag = true;
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
                            "Change Email",
                            style: TextStyle(fontSize: 30, color: primaryColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 145, left: 30),
                        child: Container(
                          child: Text(
                            "Input your old Email Address, followed by your New Email Address twice.",
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
                                  controller: _oldEmailController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "Old Email Address",
                                    prefixIcon: Icon(Icons.mail),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Ropoto',
                                        fontWeight: FontWeight.bold,
                                        color: greyIcon),
                                  ),
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
                                  controller: _newEmailController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "New Email Address",
                                    prefixIcon: Icon(Icons.mail),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Ropoto',
                                        fontWeight: FontWeight.bold,
                                        color: greyIcon),
                                  ),
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
                            controller: _confirmEmailController,
                            decoration: InputDecoration(
                              errorBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: "Confrim Email Address",
                              prefixIcon: Icon(Icons.mail),
                            ),
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
                                emailValidation();
                                if (oldEmailFlag == true &&
                                    newEmailFlag == true &&
                                    confirmEmailFlag == true)
                                  setState(() async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final result = await userService
                                        .changeEmail(_newEmailController.text);
                                    debugPrint("from Change email: " +
                                        result.status.toString());
                                    debugPrint("from Change email: " +
                                        result.result.toString());
                                    debugPrint("from Change email: " +
                                        result.hasErrors.toString());
                                    final title = result.status == 0
                                        ? 'Your Email has been Changed'
                                        : 'Error';
                                    final text = result.status == 0
                                        ? 'Please check your new email ${_newEmailController.text} for confimation links, then login once again.'
                                        : "The entered Email account doesn't exist in our database.";

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
                                                  result.status == 0
                                                      ? Container(
                                                          width: 60,
                                                          height: 60,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/shine.svg',
                                                            color: grey,
                                                          ),
                                                        )
                                                      : Container(),
                                                  result.status == 0
                                                      ? Center(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/shield.svg',
                                                            color: grey,
                                                            height: 100,
                                                          ),
                                                        )
                                                      : Container(),
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
                                else if (oldEmailFlag == false)
                                  ShowDialog("Wrong Email",
                                      "Your old Email is incorrect.");
                                else if (newEmailFlag == false)
                                  ShowDialog(
                                      "Something is wrong with the New Email.",
                                      "Please enter a proper Email Address.");
                                else if (confirmEmailFlag == false)
                                  ShowDialog("Error",
                                      "Both New Email fields don't match.");
                              },
                              child: Center(
                                child: Text(
                                  'Change Email',
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

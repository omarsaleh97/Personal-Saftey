import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/first_login.dart';
import 'package:personal_safety/services/service_firstLogin.dart';
import 'package:personal_safety/models/emergency_contact.dart';
import 'dart:core';

class SignUpSuccessful extends StatefulWidget {
  @override
  _SignUpSuccessfulState createState() => _SignUpSuccessfulState();
}

class _SignUpSuccessfulState extends State<SignUpSuccessful> {
  bool value = false;
  TextEditingController _currentAddressController = TextEditingController();
  TextEditingController _medicalHistory = TextEditingController();
  TextEditingController _bloodType = TextEditingController();

  FirstLoginService get userService => GetIt.instance<FirstLoginService>();
  FirstLoginCredentials firstLogin;
  EmergencyContacts contacts;
  List<EmergencyContacts> contactList;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 20),
              child: Text(
                "Complete your profile",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 150, left: 120),
//              child: Container(
//                width: 150,
//                height: 150,
//                decoration: BoxDecoration(
//                    color: grey, borderRadius: BorderRadius.circular(150)),
//                child: CircleAvatar(
//                  radius: 50,
//                  child: IconButton(
//                      icon: Icon(Icons.camera_enhance),
//                      iconSize: 70,
//                      color: Colors.white,
//                      onPressed: null),
//                  backgroundColor: Colors.transparent,
//                ),
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.only(top: 330.0, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        controller: _currentAddressController,
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Address",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        controller: _bloodType,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          errorBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "Blood Type",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        controller: _medicalHistory,
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: const EdgeInsets.all(20),
//                        icon: Icon(
//                          Icons.contact_phone,
//                          color: grey,
//                        ),
                          hintText: "Medical History",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.contact_phone,
                            color: grey,
                          ),
                          errorBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: const EdgeInsets.all(20),
//                        icon: Icon(
//                          Icons.contact_phone,
//                          color: grey,
//                        ),
                          hintText: "Edit Emergency Contacts",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 70.0, bottom: 10, right: 70),
                      child: Container(
                        height: 50.0,
                        width: 300,
                        child: RaisedButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          onPressed: () async {
                            setState(() async {
                              final contacts = EmergencyContacts(
                                  name: "Bola", phoneNumber: "01402650060");
                              final firstLogin = FirstLoginCredentials(
                                  currentAddress:
                                      _currentAddressController.text,
                                  bloodType: int.parse(_bloodType.text),
                                  medicalHistoryNotes: _medicalHistory.text,
                                  emergencyContacts: contactList);

                              final result =
                                  await userService.firstLogin(firstLogin);
                              debugPrint("from FIRST STATUS LOGIN: " +
                                  result.status.toString());
                              debugPrint("from FIRST RESULT LOGIN: " +
                                  result.result.toString());
                              debugPrint("from FIRST ERROR LOGIN: " +
                                  result.hasErrors.toString());
                              final title = result.status == 0
                                  ? 'Your Information is saved!'
                                  : 'Error';
                              final text = result.status == 0
                                  ? 'You will be forwarded to the next page!'
                                  : "Make sure the Phone numbers are 11 digits and that the rest of your information is correct.";
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text(title),
                                        content: Text(text),
                                        actions: <Widget>[
                                          FlatButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      )).then((data) {
                                if (result.status == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpSuccessful()));
                                }
                              });
                            });
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

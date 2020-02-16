import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';

class SignUpSuccessful extends StatefulWidget {
  @override
  _SignUpSuccessfulState createState() => _SignUpSuccessfulState();
}

class _SignUpSuccessfulState extends State<SignUpSuccessful> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: grey,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 20),
            child: Text(
              "Complete your profile",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 140),
            child: CircleAvatar(
              radius: 50,
              child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 70,
                  color: grey,
                  onPressed: null),
              backgroundColor: greyIcon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0, left: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_on,
                        color: secondary,
                      ),
                      labelText: "Address",
                      labelStyle: TextStyle(
                          fontFamily: 'Ropoto',
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Accent1),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.healing,
                        color: secondary,
                      ),
                      labelText: "Blood Type",
                      labelStyle: TextStyle(
                          fontFamily: 'Ropoto',
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Accent1),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.report_problem,
                        color: secondary,
                      ),
                      labelText: "Chronic Disease",
                      labelStyle: TextStyle(
                          fontFamily: 'Ropoto',
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Accent1),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.contact_phone,
                        color: secondary,
                      ),
                      labelText: "Edit Emergency Contacts",
                      labelStyle: TextStyle(
                          fontFamily: 'Ropoto',
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Accent1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 70.0, bottom: 10, right: 70),
                    child: Container(
                      height: 50.0,
                      width: 300,
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: secondary,
                        color: secondaryDark,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.


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
                ],
              ),
            ),
          )
        ])));
  }
}

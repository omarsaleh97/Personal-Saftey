import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/test.dart';
import 'package:personal_safety/models/first_login.dart';
import 'package:personal_safety/services/service_firstLogin.dart';
import 'package:personal_safety/models/emergency_contact.dart';
import 'dart:core';

class SignUpSuccessful extends StatefulWidget {
  @override
  _SignUpSuccessfulState createState() => _SignUpSuccessfulState();
}

class _SignUpSuccessfulState extends State<SignUpSuccessful> {
  TextEditingController _currentAddressController = TextEditingController();
  TextEditingController _medicalHistory = TextEditingController();
  TextEditingController _bloodType = TextEditingController();

  TextEditingController _emergencyName = TextEditingController();
  TextEditingController _emergencyPhone = TextEditingController();

  FirstLoginService get userService => GetIt.instance<FirstLoginService>();
  FirstLoginCredentials firstLogin;
  EmergencyContacts contacts;
  List<EmergencyContacts> contactList;

  List<BloodType> _bloodtype = BloodType.getBloodType();
  List<DropdownMenuItem<BloodType>> _dropdownMenuItem;
  BloodType _selectedBloodType;

  bool _isLoading = false;
  bool addressFlag = false;
  bool medicalHistoryFlag = false;
  bool contactNeedsPhone = false;
  bool phoneValid = false;
  bool bloodTypeValid = false;

  adressValidation() {
    if (_currentAddressController.text.isEmpty) {
      addressFlag = false;
      return "Please enter your address.";
    } else
      addressFlag = true;
  }

  medicalHistoryValidation() {
    if (_medicalHistory.text.isEmpty) {
      medicalHistoryFlag = false;
    } else
      medicalHistoryFlag = true;
  }

  contactWithPhoneValidation() {
    if (_emergencyName.text.isNotEmpty && _emergencyPhone.text.isEmpty)
      contactNeedsPhone = false;
    else
      contactNeedsPhone = true;
  }

  phoneValidation() {
    if (_emergencyPhone.text.isNotEmpty) {
      if (_emergencyPhone.text.length != 11) {
        phoneValid = false;
      } else
        phoneValid = true;
    } else
      phoneValid = true;
  }

  bloodTypeValidation() {
    if (_selectedBloodType.id == 0)
      bloodTypeValid = false;
    else
      bloodTypeValid = true;
  }

  @override
  void initState() {
    _dropdownMenuItem = buildDropdownMenuItems(_bloodtype);
    _selectedBloodType = _dropdownMenuItem[0].value;
    super.initState();
  }

  List<DropdownMenuItem<BloodType>> buildDropdownMenuItems(List types) {
    List<DropdownMenuItem<BloodType>> items = List();
    for (BloodType bloodtype in types) {
      items.add(
        DropdownMenuItem(
          value: bloodtype,
          child: Text(bloodtype.type),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(BloodType selectedCompany) {
    setState(() {
      _selectedBloodType = selectedCompany;
    });
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
                      setState(() {});
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Center(child: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 150, left: 120),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(150)),
                      child: CircleAvatar(
                        radius: 50,
                        child: IconButton(
                            icon: Icon(Icons.camera_enhance),
                            iconSize: 70,
                            color: Colors.white,
                            onPressed: null),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 330.0, left: 20, right: 20),
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
                              controller: _emergencyName,
                              decoration: InputDecoration(
                                errorBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                contentPadding: const EdgeInsets.all(20),
//                        icon: Icon(
//                          Icons.contact_phone,
//                          color: grey,
//                        ),
                                hintText: "Emergency Contact (Optional)",
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
                              controller: _emergencyPhone,
                              decoration: InputDecoration(
                                errorBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                contentPadding: const EdgeInsets.all(20),
//                        icon: Icon(
//                          Icons.contact_phone,
//                          color: grey,
//                        ),
                                hintText: "Phone Number (Optional)",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: kBoxDecorationStyle,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Select Blood Type: ",
                                    style: kLabelStyle,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  DropdownButton(
                                    itemHeight: 50,
                                    items: _dropdownMenuItem,
                                    onChanged: onChangeDropdownItem,
                                    value: _selectedBloodType,
                                  ),
                                ],
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
                                  adressValidation();
                                  medicalHistoryValidation();
                                  contactWithPhoneValidation();
                                  phoneValidation();
                                  bloodTypeValidation();
                                  if (medicalHistoryFlag == true &&
                                      addressFlag == true &&
                                      contactNeedsPhone == true &&
                                      phoneValid == true &&
                                      bloodTypeValid == true) {
                                    print("PRESSED");
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    setState(() async {
                                      final contacts = EmergencyContacts(
                                          name: _emergencyName.text,
                                          phoneNumber: _emergencyPhone.text);
                                      final firstLogin = FirstLoginCredentials(
                                          currentAddress:
                                              _currentAddressController.text,
                                          bloodType: _selectedBloodType.id,
                                          medicalHistoryNotes:
                                              _medicalHistory.text,
                                          emergencyContacts: [
                                            contacts,
                                          ]);

                                      final result = await userService
                                          .firstLogin(firstLogin);
                                      debugPrint("BLOOD TYPE IS " +
                                          _selectedBloodType.id.toString());
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
                                          : "There seems to be a problem. Try again.";
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      })
                                                ],
                                              )).then((data) {
                                        if (result.status == 0) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Test()));
                                        }
                                      });
                                    });
                                  } else if (addressFlag == false) {
                                    ShowDialog(
                                        "Error", "Address cannot be empty.");
                                  } else if (medicalHistoryFlag == false) {
                                    ShowDialog("Error",
                                        "Medical History cannot be empty.");
                                  } else if (contactNeedsPhone == false) {
                                    ShowDialog("Error",
                                        "A Contact name requires a Phone number. Either provide both, or leave both empty.");
                                  } else if (phoneValid == false) {
                                    ShowDialog("Error",
                                        "Phone Number must be 11 digits.");
                                  } else if (bloodTypeValid == false)
                                    ShowDialog(
                                        "Error", "Must select a blood type.");
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
            );
          },
        )));
  }
}

class BloodType {
  int id;
  String type;
  BloodType(this.id, this.type);

  static List<BloodType> getBloodType() {
    return <BloodType>[
      BloodType(0, 'Type'),
      BloodType(1, 'O'),
      BloodType(2, 'A'),
      BloodType(3, 'B'),
      BloodType(4, 'AB'),
    ];
  }
}

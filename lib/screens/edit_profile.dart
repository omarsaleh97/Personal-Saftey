import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_safety/Auth/change_email.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/test.dart';
import 'package:personal_safety/models/first_login.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/screens/main_page.dart';
import 'package:personal_safety/services/service_firstLogin.dart';
import 'package:personal_safety/models/emergency_contact.dart';
import 'dart:core';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  final FirstLoginCredentials profileGetter;
  EditProfile({@required this.profileGetter});
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _currentAddressController = TextEditingController();
  TextEditingController _medicalHistory = TextEditingController();
  TextEditingController _bloodType = TextEditingController();

  TextEditingController _emergencyName = TextEditingController();
  TextEditingController _emergencyPhone = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  FirstLoginService get userService => GetIt.instance<FirstLoginService>();
  FirstLoginCredentials firstLogin;
  EmergencyContacts contacts;
  List<EmergencyContacts> contactList;
  DateTime birthDate;

  List<BloodType> _bloodtype = BloodType.getBloodType();
  List<DropdownMenuItem<BloodType>> _dropdownMenuItem;
  BloodType _selectedBloodType;

  bool _isLoading = false;
  bool addressFlag = false;
  bool medicalHistoryFlag = false;
  bool contactNeedsPhone = false;
  bool phoneValid = false;
  bool userPhoneValid = false;
  bool bloodTypeValid = false;
  bool fullNameFlag = false;
  bool birthDateFlag = false;

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

  dateValidation() {
    if (birthDate == null) {
      birthDateFlag = false;
    } else
      birthDateFlag = true;
  }

  fullNameValidation() {
    if (_fullNameController.text.isEmpty) {
      fullNameFlag = false;
    } else
      fullNameFlag = true;
  }

  contactWithPhoneValidation() {
    if (_emergencyName.text.isNotEmpty && _emergencyPhone.text.isEmpty)
      contactNeedsPhone = false;
    else if (_emergencyName.text.isEmpty && _emergencyPhone.text.isNotEmpty)
      contactNeedsPhone = false;
    else
      contactNeedsPhone = true;
  }

  emergencyContactPhoneValidation() {
    if (_emergencyPhone.text.isNotEmpty) {
      if (_emergencyPhone.text.length != 11) {
        phoneValid = false;
      } else
        phoneValid = true;
    } else
      phoneValid = true;
  }

  phoneNumberValidation() {
    if (_phoneNumberController.text.isNotEmpty) {
      if (_phoneNumberController.text.length != 11) {
        userPhoneValid = false;
      } else
        userPhoneValid = true;
    } else
      userPhoneValid = false;
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
    _selectedBloodType =
        _dropdownMenuItem[widget.profileGetter.bloodType].value;
    _fullNameController.text = widget.profileGetter.fullName;
    _phoneNumberController.text = widget.profileGetter.phoneNumber;
    _currentAddressController.text = widget.profileGetter.currentAddress;
    _emergencyName.text = widget.profileGetter.emergencyContacts[0].name;
    _emergencyPhone.text =
        widget.profileGetter.emergencyContacts[0].phoneNumber;
    _medicalHistory.text = widget.profileGetter.medicalHistoryNotes;
    setState(() {
      birthDate = DateTime.parse(widget.profileGetter.birthday);
    });

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit your profile",
            style: TextStyle(fontSize: 20, color: primaryColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: primaryColor, //change your color here
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () async {
                  fullNameValidation();
                  phoneNumberValidation();
                  dateValidation();
                  adressValidation();
                  medicalHistoryValidation();
                  contactWithPhoneValidation();
                  emergencyContactPhoneValidation();
                  bloodTypeValidation();
                  if (birthDateFlag == true &&
                      fullNameFlag == true &&
                      userPhoneValid == true &&
                      medicalHistoryFlag == true &&
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
                          fullName: _fullNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          birthday: DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(birthDate.toString())),
                          currentAddress: _currentAddressController.text,
                          bloodType: _selectedBloodType.id,
                          medicalHistoryNotes: _medicalHistory.text,
                          emergencyContacts: [
                            contacts,
                          ]);

                      final result = await userService.firstLogin(firstLogin);

                      final title = result.status == 0
                          ? 'Your Profile is updated!'
                          : 'Error';
                      final text = result.status == 0
                          ? 'Your info will be shown as updated.'
                          : "There seems to be a problem. Try again. Your Phone number may be taken.";
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
                                      style: TextStyle(color: grey),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text('OK',
                                          style: TextStyle(color: grey)),
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.of(context).pop();
                                      })
                                ],
                              )).then((data) {
                        if (result.status == 0) {
                          StaticVariables.prefs.setBool("firstlogin", false);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      });
                    });
                  } else if (fullNameFlag == false) {
                    ShowDialog("Error", "Full Name cannot be empty.");
                  } else if (userPhoneValid == false) {
                    ShowDialog("Error", "Your Phone Number must be 11 digits.");
                  } else if (birthDateFlag == false) {
                    ShowDialog("Error", "Full Name cannot be empty.");
                  } else if (addressFlag == false) {
                    ShowDialog("Error", "Address cannot be empty.");
                  } else if (medicalHistoryFlag == false) {
                    ShowDialog("Error", "Medical History cannot be empty.");
                  } else if (contactNeedsPhone == false) {
                    ShowDialog("Error",
                        "A Contact name requires a Phone number. Either provide both, or leave both empty.");
                  } else if (phoneValid == false) {
                    ShowDialog(
                        "Error", "Emergency Phone Number must be 11 digits.");
                  } else if (bloodTypeValid == false)
                    ShowDialog("Error", "Must select a blood type.");
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: primaryColor),
                )),
          ],
        ),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Center(child: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(
                  child: CustomLoadingIndicator(
                customColor: primaryColor,
              ));
            }
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/ProfilePic.png')),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                                width: 5,
                                color: grey,
                                style: BorderStyle.solid)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle2,
                                child: TextField(
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: "Full Name",
                                    hintStyle: kHintStyle,
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
                                  controller: _phoneNumberController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: "Phone Number",
                                    hintStyle: kHintStyle,
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
                                  controller: _currentAddressController,
                                  decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: "Address",
                                    hintStyle: kHintStyle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle2,
                                child: CustomTextField(
                                  customController: _medicalHistory,
                                  customHint: "Medical History",
                                  hintStyle: kHintStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle2,
                                child: CustomTextField(
                                  customController: _emergencyName,
                                  customHint: "Emergency Contact (Optional)",
                                  hintStyle: kHintStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle2,
                                child: CustomTextField(
                                  customController: _emergencyPhone,
                                  customHint: "Contact Number (Optional)",
                                  hintStyle: kHintStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                        width: 0.5, color: greyIcon)),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Select Blood Type: ",
                                        style: kHintStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    DropdownButton(
                                      style: TextStyle(
                                          fontSize: 13, color: primaryColor),
                                      itemHeight: 50,
                                      items: _dropdownMenuItem,
                                      onChanged: onChangeDropdownItem,
                                      value: _selectedBloodType,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                        width: 0.5, color: greyIcon)),
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1960, 1, 1),
                                          maxTime: DateTime(2022, 12, 31),
                                          onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        setState(() {
                                          birthDate = date;
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: Text(
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(birthDate.toString())),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeEmail()));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.email,
                                          color: Colors.black26,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Change Email Address",
                                          style: kHintStyle,
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewPassword()));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.vpn_key,
                                          color: Colors.black26,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Change Password",
                                          style: kHintStyle,
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/screens/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Accent1,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(
                        width: 5,
                        color: primaryColor.withOpacity(0.5),
                        style: BorderStyle.solid)),
              ),
              SizedBox(
                height: 10,
              ),
//              Badge(),
              Padding(
                padding: const EdgeInsets.only(left: 165.0),
                child: Container(
                  width: 37,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Accent1),
                  child: Center(
                      child: Text(
                    "4.4",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              Text(
                "UserName",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                height: 50.0,
                width: 300,
                child: RaisedButton(
                  color: Accent2,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  //_save("0");
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('token');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Logout()));
                },
              ),
              SizedBox(height: 50),

              SvgPicture.asset(
                'assets/images/invoice.svg',
                width: 150,
                height: 200,
                color: greyIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

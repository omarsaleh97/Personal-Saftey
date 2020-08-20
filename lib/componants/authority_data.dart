import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/others/GlobalVar.dart';
import 'package:personal_safety/screens/home.dart';
import '../models/authorityType.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthorityData {
  static List<Authority> AuthorityList = [
    Authority(
      id: 1,
      image: SvgPicture.asset(
        'assets/images/badge.svg',
        width: 40,
        height: 40,
      ),
      description: Text(
        "Request law enforcement forces",
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300),
      ),
      name: Text(
        "Police",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      button: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8),
        ),
        onPressed: ()
        {
          GlobalVar.Set("sosrequesttype", 1);
          print("sosrequest type is now: " + GlobalVar.Get("sosrequesttype", 1).toString());
        },
        child: Text(
          "Request",
          style: TextStyle(color: Color(0xff006E90),fontSize: 12),
        ),
        color: Colors.white,
      ),
    ),
    Authority(
      id: 2,
      image: SvgPicture.asset(
        'assets/images/ambulance.svg',
        width: 40,
        height: 40,
      ),
      description: Text(
        "Request law enforcement forces",
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300),
      ),      name: Text(
        "Ambulance",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      button: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8),
        ),
        onPressed: ()
        {
          GlobalVar.Set("sosrequesttype", 2);
          print("sosrequest type is now: " + GlobalVar.Get("sosrequesttype", 1).toString());
        },
        child: Text(
          "Request",
          style: TextStyle(color: Color(0xff006E90),fontSize: 12),
        ),
        color: Colors.white,
      ),
    ),
    Authority(
      id: 3,
      image: SvgPicture.asset(
        'assets/images/firefighter.svg',
        width: 40,
        height: 40,
      ),
      description: Text(
        "Request law enforcement forces",
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300),
      ),      name: Text(
        "Firefighting",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      button: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8),
        ),
        onPressed: ()
  {
            GlobalVar.Set("sosrequesttype", 3);
            print("sosrequest type is now: " + GlobalVar.Get("sosrequesttype", 1).toString());
  },
        child: Text(
          "Request",
          style: TextStyle(color: Color(0xff006E90),fontSize: 12),
        ),
        color: Colors.white,
      ),
    ),
    Authority(
      id: 4,
      image: SvgPicture.asset(
        'assets/images/tow-truck.svg',
        width: 40,
        height: 40,
      ),
      description: Text(
        "Request law enforcement forces",
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300),
      ),      name: Text(
        "Tow Truck",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      button: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8),
        ),
        onPressed: ()
        {
          GlobalVar.Set("sosrequesttype", 4);
          print("sosrequest type is now: " + GlobalVar.Get("sosrequesttype", 1).toString());
        },
        child: Text(
          "Request",
          style: TextStyle(color: Color(0xff006E90),fontSize: 12),
        ),
        color: Colors.white,
      ),
    ),
  ];
}




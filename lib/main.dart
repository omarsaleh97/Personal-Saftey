import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/confirm.dart';
import 'package:personal_safety/Auth/forgetPassword.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/Auth/signup.dart';
import 'package:personal_safety/Auth/signupSuccessful.dart';
import 'package:personal_safety/componants/card.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Logout(),
//    routes: {
//     // '/home':(context)=>Home(),
//
//     '/':(context)=>Login(),
//      '/logout':(context)=>Logout(),
//
//
//    },
  ));
}


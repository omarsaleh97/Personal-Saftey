import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/confirm.dart';
import 'package:personal_safety/Auth/forgetPassword.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/Auth/signup.dart';
import 'package:personal_safety/Auth/signupSuccessful.dart';
import 'package:personal_safety/componants/card.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/services/service_login.dart';
import 'package:personal_safety/services/service_register.dart';

import 'componants/test.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => RegisterService());
}

void main() {
  setupLocator();

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

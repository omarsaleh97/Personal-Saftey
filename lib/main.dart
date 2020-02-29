import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/confirmCode.dart';
import 'package:personal_safety/Auth/Confirm_newEmail.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/Auth/signup.dart';
import 'package:personal_safety/Auth/signupSuccessful.dart';
import 'package:personal_safety/componants/card.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/services/service_confirm.dart';
import 'package:personal_safety/services/service_login.dart';
import 'package:personal_safety/services/service_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'componants/test.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => RegisterService());
  GetIt.instance.registerLazySingleton(() => ConfirmService());

}

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
//      home: token == null ? Logout() : Test()
  home: ConfirmEmail(),
//  home: ConfirmCode(),
      ));
}

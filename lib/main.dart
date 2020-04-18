import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/confirmCode.dart';
import 'package:personal_safety/Auth/Confirm_newEmail.dart';
import 'package:personal_safety/Auth/forget_password.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/Auth/signup.dart';
import 'package:personal_safety/Auth/signupSuccessful.dart';
import 'package:personal_safety/componants/card.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/screens/main_page.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/services/service_confirm.dart';
import 'package:personal_safety/services/service_firstLogin.dart';
import 'package:personal_safety/services/service_forgetpassword.dart';
import 'package:personal_safety/services/service_login.dart';
import 'package:personal_safety/services/service_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'componants/test.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => RegisterService());
  GetIt.instance.registerLazySingleton(() => ConfirmService());
  GetIt.instance.registerLazySingleton(() => ForgetPasswordService());
  GetIt.instance.registerLazySingleton(() => FirstLoginService());
}

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await StaticVariables.Init();
  StaticVariables.prefs.setString("activerequeststate", "Searching");

  if (!StaticVariables.prefs.containsKey("firstlogin"))
    StaticVariables.prefs.setBool("firstlogin", true);

  var token = StaticVariables.prefs.getString('token');
  print(token);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,

    home: token == null ? Logout() : MainPage()
 //home: MainPage(),
//  home: ConfirmCode(),
      ));
}

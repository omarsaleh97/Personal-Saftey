
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
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/events.dart';
import 'package:personal_safety/screens/main_page.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/screens/search.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/services/service_confirm.dart';
import 'package:personal_safety/services/service_login.dart';
import 'package:personal_safety/services/service_register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'componants/test.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => RegisterService());
  GetIt.instance.registerLazySingleton(() => ConfirmService());
}

Future<void> main() async {
  //SocketHandler.ConnectSocket();
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);
  // ignore: missing_required_param
  runApp(ChangeNotifierProvider(
    builder: (context) => EventModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: token == null ? Logout() : MainPage()
       home: Events(),
      //home: News(),
    ),
  ));
}

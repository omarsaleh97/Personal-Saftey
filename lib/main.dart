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
import 'package:personal_safety/services/event_categories_service.dart';
import 'package:personal_safety/services/service_confirm.dart';
import 'package:personal_safety/services/service_firstLogin.dart';
import 'package:personal_safety/services/service_login.dart';
import 'package:personal_safety/services/service_register.dart';
import 'package:provider/provider.dart';
import 'screens/events.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'others/StaticVariables.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => LoginService());
  GetIt.instance.registerLazySingleton(() => RegisterService());
  GetIt.instance.registerLazySingleton(() => ConfirmService());
  GetIt.instance.registerLazySingleton(() => FirstLoginService());
  GetIt.instance.registerLazySingleton(() => EventCategoriesService());
}

Future<void> main() async {
  bool firstlogin = StaticVariables.prefs.getBool("firstlogin");
  if (firstlogin == null) StaticVariables.prefs.setBool("firstlogin", false);
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await StaticVariables.Init();
  StaticVariables.prefs.setString("activerequeststate", "Searching");

  print('First Login token is: $firstlogin');

  var token = StaticVariables.prefs.getString('token');
  print("Saved token used for Remember Me: $token");

  runApp(ChangeNotifierProvider(
    builder: (context) => EventModel(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: token == null ? Logout() : MainPage()
//      home: Events(),
        //home: News(),
        ),
  ));
}

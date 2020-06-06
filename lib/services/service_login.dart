import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/login.dart';
import 'dart:developer';

import 'package:personal_safety/others/StaticVariables.dart';

class LoginService {
  static var token = '';
  static const headers = {'Content-Type': 'application/json'};

  // Logging In
  Future<APIResponse<dynamic>> Login(LoginCredentials item) async {
    String finalString = StaticVariables.API + '/api/Account/Login';

    print("Trying to login to " + finalString);

    return http
        .post(finalString, headers: headers, body: json.encode(item.toJson()))
        .then((data) async {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
//        APIResponse<LoginResponse> test =
        var APIresult = APIResponse.fromJson(userMap);

        var retrievedToken =
            userMap['result']['authenticationDetails']['token'];
        var refreshToken =
            userMap['result']['authenticationDetails']['refreshToken'];
        var currentDate = DateTime.now();

        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", retrievedToken);
        prefs.setString("tokenDate", currentDate.toString());
        prefs.setString("refreshToken", refreshToken);

        print('From Login Service:  ${APIresult.status}');

        token = retrievedToken;
        print(" retrieved token from login service:  " + token);
        print('From Login Service:  ${APIresult.hasErrors}');

        return APIresult;
      } else {
        print("Tried to login but failed ;_;");
      }
      return APIResponse<dynamic>(
          hasErrors: true, messages: "An Error Has Occured");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: "An Error Has Occured"));
  }
}

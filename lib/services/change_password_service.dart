import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/change_password.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordService {
  static String token;
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print("TOKEN");
    print(token.toString());
    print("TOKEN");
    return token;
  }

//  Future<void> setToken() async {
//    token = await getToken();
//    print("Token is set!");
//  }

  static bool result = false;
  //static const API = 'https://personalsafety.azurewebsites.net/';

  // Register
  Future<APIResponse<dynamic>> changePassword(
      ChangePasswordCredentials item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return http
        .post(StaticVariables.API + '/api/Account/ChangePassword',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        //print(APIresult.toString());
        print("!!!!!! FROM CHANGE PASSWORD SERVICE !!!!!!\n");
        print(APIresult.status);
        print(APIresult.result);
        //result = APIresult.result;
        print(APIresult.hasErrors);
        print("\n!!!!!! FROM CHANGE PASSWORD SERVICE !!!!!!");

        return APIresult;
      } else {
        print("BAD TEST");
        print(headers);

        print(data.statusCode);
      }
      return APIResponse<dynamic>(
          hasErrors: true, messages: "Your old Password is incorrect.");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: "Your old Password is incorrect."));
  }
}

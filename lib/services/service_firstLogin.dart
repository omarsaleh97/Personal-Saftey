import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/first_login.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class FirstLoginService {
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
  Future<APIResponse<dynamic>> firstLogin(FirstLoginCredentials item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return http
        .put(StaticVariables.API + '/api/Client/Registration/EditProfile',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        print("TEST TEST TEST --------------------------------- ");
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        //print(APIresult.toString());
        print("TEST TEST TEST --------------------------------- ");

        print(APIresult.status);
        print(APIresult.result);
        //result = APIresult.result;
        print(APIresult.hasErrors);
        print("TEST TEST TEST --------------------------------- ");

        return APIresult;
      } else {
        print("BAD TEST");
        print(headers);

        print(data.statusCode);
      }
      return APIResponse<dynamic>(
          hasErrors: true,
          messages:
              "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits.");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true,
            messages:
                "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits."));
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/login.dart';
import 'dart:developer';

import 'package:personal_safety/others/StaticVariables.dart';

class LoginService {
  static var token = '';
  static const headers = {'Content-Type': 'application/json'};

  // Logging In
  Future<APIResponse<dynamic>> Login(LoginCredentials item) {

    String finalString = StaticVariables.API + '/api/Account/Login';

    print("Trying to login to " + finalString);

    return http
        .post(finalString,
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.status);
        print(APIresult.result);
        token = APIresult.result;
        print(APIresult.hasErrors);
        return APIresult;
      }
      else
        {

          print("Tried to login but failed ;_;");

        }
      return APIResponse<dynamic>(
          hasErrors: true, messages: "An Error Has Occured");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: "An Error Has Occured"));

  }
}

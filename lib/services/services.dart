import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/login.dart';
import 'dart:developer';

class UserService {
  static var token = '';
  static const API = 'https://personalsafety.azurewebsites.net/';
  static const headers = {'Content-Type': 'application/json'};

  // Logging In
  Future<APIResponse<dynamic>> Login(LoginCredentials item) {
    return http
        .post(API + '/api/Account/Login',
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
      return APIResponse<dynamic>(
          hasErrors: true, messages: 'An Error Occured.');
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: 'An Error Occured.'));
  }
}

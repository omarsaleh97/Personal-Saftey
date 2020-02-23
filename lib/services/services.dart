import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/login.dart';

class UserService {
  static const API = 'https://personalsafety.azurewebsites.net/';
  static const headers = {'Content-Type': 'application/json'};

  // Logging In
  Future<APIResponse<bool>> Login(LoginCredentials item) {
    return http
        .post(API + '/api/Account/Login',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(
          result: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessages: 'An Error Occured.');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessages: 'An Error Occured.'));
  }
}

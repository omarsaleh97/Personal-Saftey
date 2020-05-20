import 'package:http/http.dart' as http;
import 'package:personal_safety/models/refresh_token.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/login.dart';
import 'dart:developer';

import 'package:personal_safety/others/StaticVariables.dart';

class RefreshTokenService {
  static const headers = {'Content-Type': 'application/json'};

  Future<bool> saveTokenPreference(String token, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = token;
    prefs.setString(key, value);
  }

  // Logging In
  Future<APIResponse<dynamic>> RefreshToken(RefreshTokenCredentials item) {
    String finalString = StaticVariables.API + '/api/Account/RefreshToken';

    return http
        .post(finalString, headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
//        APIResponse<LoginResponse> test =
        var APIresult = APIResponse.fromJson(userMap);

        var retrievedToken =
            userMap['result']['authenticationDetails']['token'];
        var refreshToken =
            userMap['result']['authenticationDetails']['refreshToken'];
        var currentDate = DateTime.now();

        saveTokenPreference(retrievedToken, "token");
        saveTokenPreference(refreshToken, "refreshToken");
        saveTokenPreference(currentDate.toString(), "tokenDate");
        print('From Refresh Token Service:  ${APIresult.status}');
        print('From Refresh Token Service:  ${APIresult.hasErrors}');

        return APIresult;
      } else {
        print("refresh token failed ;_;");
      }
      return APIResponse<dynamic>(
          hasErrors: true, messages: "An Error Has Occured");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: "An Error Has Occured"));
  }
}

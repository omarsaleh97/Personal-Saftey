import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/emergency_contact.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/first_login.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class GetProfileService {
  static String token;

  static bool result = false;
  static var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  // Register
  Future<APIResponse<FirstLoginCredentials>> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    return http
        .get(
      StaticVariables.API + '/api/Client/Registration/GetProfile',
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 200) {
        print("FROM GET PROFILE SERVICE: " + token);
        print("TEST SUCESSFUL!!!!!!! ");
        Map userMap = jsonDecode(data.body);
        print(userMap["result"]["currentAddress"]);

        List<EmergencyContacts> emergencyContactsList;
        var rest = userMap["result"]["emergencyContacts"] as List;
        emergencyContactsList = rest
            .map<EmergencyContacts>((json) => EmergencyContacts.fromJson(json))
            .toList();
        FirstLoginCredentials profileList = new FirstLoginCredentials();
        profileList = FirstLoginCredentials(
          fullName: userMap["result"]["fullName"],
          phoneNumber: userMap["result"]["phoneNumber"],
          currentAddress: userMap["result"]["currentAddress"],
          bloodType: userMap["result"]["bloodType"],
          medicalHistoryNotes: userMap["result"]["medicalHistoryNotes"],
          birthday: userMap["result"]["birthday"],
          emergencyContacts: emergencyContactsList,
        );
        print("DEBUG PRINT FROM GET PROFILE SERVICE:  ${profileList.fullName}");
        print(
            "DEBUG PRINT FROM GET PROFILE SERVICE:  ${profileList.emergencyContacts[0].phoneNumber}");

        return APIResponse<FirstLoginCredentials>(result: profileList);
      } else {
        print("BAD TEST");
        print(headers);

        print(data.statusCode);
      }
      return APIResponse<FirstLoginCredentials>(hasErrors: true, messages: '');
    }).catchError((_) =>
            APIResponse<FirstLoginCredentials>(hasErrors: true, messages: ''));
  }
}

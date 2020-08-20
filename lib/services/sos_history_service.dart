import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/sos_request_model.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SOSHistoryService {
  static String token;

  static bool result = false;

  // Register
  Future<APIResponse<List<SOSRequestModel>>> getSOSHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return http
        .get(
      StaticVariables.API + '/api/Client/SOS/GetSOSRequestsHistory',
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 200) {
        print("SOS REQUEST HISTORY GET SUCESSFUL!!!!!!! ");
        final jsonData = json.decode(data.body);
        var rest = jsonData["result"] as List;
        List<SOSRequestModel> requestList;
//        print(rest);
        requestList = rest
            .map<SOSRequestModel>((json) => SOSRequestModel.fromJson(json))
            .toList();

        return APIResponse<List<SOSRequestModel>>(result: requestList);
      } else {
        print("BAD TEST");
        print(headers);

        print(data.statusCode);
      }
      return APIResponse<List<SOSRequestModel>>(hasErrors: true, messages: '');
    }).catchError((_) =>
            APIResponse<List<SOSRequestModel>>(hasErrors: true, messages: ''));
  }
}

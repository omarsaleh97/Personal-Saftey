import 'package:http/http.dart' as http;
import 'package:personal_safety/models/device_token_update.dart';
import 'dart:convert';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDeviceTokenService {
  static String token;

  static var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

//  int requestID = StaticVariables.prefs.getInt("activerequestid");
//  int rate = StaticVariables.prefs.getInt("rescuerRate");

  // Logging In
  Future<APIResponse<dynamic>> updateDeviceToken(DeviceToken item) async {
    print("PRINTING FCM TOKEN FROM SERVICE: " + item.deviceRegistrationKey);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return http
        .post(
            StaticVariables.API +
                '/api/Client/Events/UpdateDeviceRegistraionKey',
            headers: headers,
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        print('UPDATING FCM TOKEN');

        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print("Status from UPDATE TOKEN ${APIresult.status}");
        print(APIresult.result);
        //result = APIresult.result;
        print(APIresult.hasErrors);
        return APIresult;
      } else {
        print('============================');
        print(data.statusCode);
        print("-----------------------------");
      }
      return APIResponse<dynamic>(
          hasErrors: true, messages: "An Error Has Occured");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: "An Error Has Occured"));
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/confirm_mail.dart';
import 'package:personal_safety/models/confirm_token.dart';
import 'package:personal_safety/others/StaticVariables.dart';

class ConfirmTokenService {
  static var token = '';
//  static const API = 'https://personalsafety.azurewebsites.net/';
  static const headers = {'Content-Type': 'application/json'};

  // Logging In
  Future<APIResponse<dynamic>> confirmToken(ConfirmTokenCredentials item) {
    return http
        .post(StaticVariables.API + '/api/Account/SubmitConfirmation',
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
          hasErrors: true, messages: "An Error Has Occured");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true, messages: "An Error Has Occured"));
  }
}

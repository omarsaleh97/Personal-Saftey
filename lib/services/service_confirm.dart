import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/confirm_mail.dart';

class ConfirmService {
  static var result = '';
  //static const API = 'https://personalsafety.azurewebsites.net/';
  static const headers = {'Content-Type': 'application/json'};

  // Logging In
  Future<APIResponse<dynamic>> confirmMail(ConfirmMailCredentials item) {
    print('*****************');

    return http
        .get(
            StaticVariables.API +
                '/api/Account/SendConfirmationMail' +
                '?email=' +
                item.email,
            headers: headers)
        .then((data) {
      print('??????????????????????');
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.status);
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

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/firstSignup.dart';
import 'package:personal_safety/models/register.dart';
import 'dart:developer';
import 'package:personal_safety/others/StaticVariables.dart';


class FirstSignupService {
  static bool result = false;
  //static const API = 'https://personalsafety.azurewebsites.net/';
  static const headers = {'Content-Type': 'application/json'};
  // Register
  Future<APIResponse<dynamic>> FirstSignup(FirstSignupCredentials item) {
//    return http
//        .post(StaticVariables.API + '/api/User/CompleteProfile',
//           headers: headers, body: json.encode(item.json()))
//        .then((data) {
//      if (data.statusCode == 200) {
//        print("TEST TEST TEST --------------------------------- ");
//        Map userMap = jsonDecode(data.body);
//        var APIresult = APIResponse.fromJson(userMap);
//        //print(APIresult.toString());
//
//        print(APIresult.status);
//        print(APIresult.result);
//        //result = APIresult.result;
//        print(APIresult.hasErrors);
//        return APIresult;
//      }
//      return APIResponse<dynamic>(
//          hasErrors: true,
//          messages:
//              "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits.");
//    }).catchError((_) => APIResponse<dynamic>(
//            hasErrors: true,
//            messages:
//                "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits."));
}
}

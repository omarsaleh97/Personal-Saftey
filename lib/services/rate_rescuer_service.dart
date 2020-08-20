import 'package:http/http.dart' as http;
import 'package:personal_safety/models/rescuer_rate_model.dart';
import 'dart:convert';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateRescuerService {
  static String token;

//  int requestID = StaticVariables.prefs.getInt("activerequestid");
//  int rate = StaticVariables.prefs.getInt("rescuerRate");

  // Logging In
  Future<APIResponse<dynamic>> rateRescuer(RateRescuerModel item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return http
        .post(
            StaticVariables.API +
                'api/Client/SOS/RateRescuer?requestId=${item.requestID}&rate=${item.rescuerRate}',
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print('Rating Rescuer');

        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print("Status from Rescuer Rate:${APIresult.status}");
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

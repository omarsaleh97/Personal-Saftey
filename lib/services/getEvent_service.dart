import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class GetEventsService {
  static String token;
  static int categoryID;
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print("TOKEN");
    print(token.toString());
    print("TOKEN");
    return token;
  }

  static bool result = false;

  // Register
  Future<APIResponse<List<EventGetterModel>>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    categoryID = prefs.getInt("categoryID");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    if (categoryID == null) categoryID = 0;
    return http
        .get(
      StaticVariables.API +
          '/api/Client/Events/GetEventsDetailed?filter=$categoryID',
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        var rest = jsonData["result"] as List;
        List<EventGetterModel> eventList;
//        print(rest);
        eventList = rest
            .map<EventGetterModel>((json) => EventGetterModel.fromJson(json))
            .toList();

        StaticVariables.eventsList = eventList;

        return APIResponse<List<EventGetterModel>>(result: eventList);
      } else {
        print("BAD TEST");
        print(headers);

        print(data.statusCode);
      }
      return APIResponse<List<EventGetterModel>>(hasErrors: true, messages: '');
    }).catchError((_) =>
            APIResponse<List<EventGetterModel>>(hasErrors: true, messages: ''));
  }
}

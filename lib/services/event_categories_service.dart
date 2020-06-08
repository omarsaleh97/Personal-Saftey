import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/event_categories.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class EventCategoriesService {
  static String token;
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print("TOKEN");
    print(token.toString());
    print("TOKEN");
    return token;
  }

//  Future<void> setToken() async {
//    token = await getToken();
//    print("Token is set!");
//  }

  static bool result = false;

  // Register
  Future<APIResponse<List<EventCategories>>> getEventCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return http
        .get(
      StaticVariables.API + '/api/Client/Events/GetEventsCategories',
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 200) {
        print("TEST SUCESSFUL!!!!!!! ");
        final jsonData = json.decode(data.body);
        var rest = jsonData["result"] as List;
        List<EventCategories> eventCategoriesList;
//        print(rest);
        eventCategoriesList = rest
            .map<EventCategories>((json) => EventCategories.fromJson(json))
            .toList();

        return APIResponse<List<EventCategories>>(result: eventCategoriesList);
      } else {
        print("BAD TEST");
        print(headers);

        print(data.statusCode);
      }
      return APIResponse<List<EventCategories>>(hasErrors: true, messages: '');
    }).catchError((_) =>
            APIResponse<List<EventCategories>>(hasErrors: true, messages: ''));
  }
}

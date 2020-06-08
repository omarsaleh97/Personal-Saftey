import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaticVariables {
  //static const

  static const API = 'https://personalsafety.azurewebsites.net/', //Publish
      //API = 'http://192.168.1.4:5566', //Test
      clientServerURL = API + "/hubs/client",
      realtimeServerURL = API + "/hubs/realtime";

  static SharedPreferences prefs;

  static var pinsList = new List();
  static List<EventGetterModel> eventsList = new List<EventGetterModel>();

  static Future<void> Init() async {
    prefs = await SharedPreferences.getInstance();
    //static const API = 'http://192.168.1.4:5566'; //Test
    const API = 'https://personalsafety.azurewebsites.net/'; //Publish
  }

}

class ServerPin
{

  ServerPin(String email, LatLng pos)
  {
    userEmail = email;
    position = pos;
  }

  String userEmail;
  LatLng position;

}
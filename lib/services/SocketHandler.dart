import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as DistanceLatLong;
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/others/GlobalVar.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/screens/map_screen.dart';
import 'package:personal_safety/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class SocketHandler {
  static bool connectionIsOpen = false;
  static HubConnection _hubConnection;

  static bool updatingLocation = false;

  static Future<void> ConnectToClientChannel() async {
    print("Trying to connect to client channel..");

    final httpOptions = new HttpConnectionOptions(
        accessTokenFactory: () async => await getAccessToken());

    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder()
          .withUrl(StaticVariables.clientServerURL, options: httpOptions)
          .build();
      _hubConnection.onclose((error) => connectionIsOpen = false);
      _hubConnection.on("ConnectionInfoChannel", SaveConnectionID_Client);
      _hubConnection.on("ClientChannel", UpdateUserSOSState);
      _hubConnection.on("ClientEventsChannel", GetVolunteerLocation);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      if (_hubConnection.state != HubConnectionState.Disconnected)
        await _hubConnection.stop();
      await _hubConnection.start();
      connectionIsOpen = true;
      //StartSharingLocation("START_LOCATION_SHARING", 11, 15);
    }
  }

  static int distanceThreshold = 10; //10 meters

  static void StartSendingLocation()
  {

    if (updatingLocation)
      return;

    updatingLocation = true;

    Timer timer;

    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {

      TrySendingLocation();

    });

  }

  static void TrySendingLocation() async
  {

    DistanceLatLong.Distance distance = new DistanceLatLong.Distance();

    Position newestLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Position emptyPosition = new Position(latitude: 0.0, longitude: 0.0);

    Position lastSentLocation = GlobalVar.Get("lastsentlocation", emptyPosition);

    int metersSinceLastUpdate = distance(
        new DistanceLatLong.LatLng(newestLocation.latitude, newestLocation.longitude),
        new DistanceLatLong.LatLng(lastSentLocation.latitude, lastSentLocation.longitude)
    ).toInt();

    if (metersSinceLastUpdate >= distanceThreshold) {
      print("Sending new location because meters since last update are: " + metersSinceLastUpdate.toString());
      UpdateLastKnownLocation(newestLocation);
    }
    else
      print("Not sending new location because meters since last update are: " + metersSinceLastUpdate.toString());

  }

  static void Disconnect() {
    try {
      if (_hubConnection.state == HubConnectionState.Connected) {
        debugPrint("Terminating connection..");
        _hubConnection.stop();
      }
    } catch (e) {}
  }

  static void GetVolunteerLocation(List<Object> args) {
    print("printing from Get Volunteer Location" + args[1].toString());

    StaticVariables.pinsList.add(new ServerPin(args[0].toString(),
        new LatLng(double.parse(args[1].toString()),
            double.parse(args[2].toString()))));

//    MapScreen.SetUserPin(
//        args[0].toString(),
//        new LatLng(double.parse(args[1].toString()),
//            double.parse(args[2].toString())));
  }

  //#region ClientSOSRequest

  static void SaveConnectionID_Client(List<Object> args) {
    print("Connected to client hub! connection ID is: " + args[0].toString());

    StaticVariables.prefs.setString('connectionid_client', args[0].toString());
  }

  static String token = "";
  static bool result = false;
  static var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  static void SetActiveSOSRequestState(String newState) {
    print("Setting active SOS request state with " + newState);
    StaticVariables.prefs.setString("activerequeststate", newState);

    StartPendingTimeout(newState);
  }

  static void SendLocationToServer(String userEmail, int eventId) async {
    try {
      print(
          "Sending location to server from Socket Handler, EVENT ID: $eventId, Email: $userEmail");
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      _hubConnection.invoke("SendToEventRoom", args: <Object>[
        userEmail,
        eventId,
        position.latitude,
        position.longitude
      ]);
    } catch (e) {
      print("Couldn't send location to server. " + e.toString());
    }
  }

  static void JoinEventRoom(String userEmail, int eventId) {
    _hubConnection.invoke("JoinEventRoom", args: <Object>[userEmail, eventId]);
  }

  static void LeaveEventRoom(String userEmail, int eventId) {
    _hubConnection.invoke("LeaveEventRoom", args: <Object>[userEmail, eventId]);
  }

  static void StartPendingTimeout(String state) {
    int timeoutSeconds = 1000;

    switch (state) {
      case "Searching":
        timeoutSeconds = 1000;
        break;

      case "Pending":
        timeoutSeconds = 1000;
        break;

      default:
        return;
    }

    Timer timer;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      String activeRequestState =
          StaticVariables.prefs.getString("activerequeststate");
      if (--timeoutSeconds < 0 && activeRequestState == state) {
        print("Time: " + timeoutSeconds.toString());
        print("Timed out because of waiting too long on state: " + state);
        timer.cancel();

        try {
          CancelSOSRequest(StaticVariables.prefs.getInt("activerequestid"));
        } catch (Ex) {
          print("Couldn't cancel SOS request. \n Exception: " + Ex.toString());
        }
      } else if (activeRequestState != state) {
        print("Disposing timer because state changed to: " + state);
        timer.cancel();
      }
    });
  }

  static void UpdateLastKnownLocation(Position newestLocation) async {
    String jsonRequest = await GetLastKnownLocationJson(newestLocation);

    print("Calling API UpdateLastKnownLocation with request " + jsonRequest + " ..");

    token = StaticVariables.prefs.getString('token');
    return http
        .post(StaticVariables.API + '/api/Client/Events/UpdateLastKnownLocation',
        headers: headers, body: jsonRequest)
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.toString());
        print("Updated last location successfully");
        print(data.statusCode);
        print(APIresult.result);
      } else {
        print("Updated last location failure");
        print(headers);
        print(data.statusCode);
      }

    });

  }

  static Future<APIResponse<dynamic>> GetEventById(int eventId) async {

    print("Calling API GetEventById with eventId " + eventId.toString());

    token = StaticVariables.prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    token = StaticVariables.prefs.getString('token');
    return http
        .put(StaticVariables.API + '/api/Client/Events/GetEventById?eventId=$eventId',
        headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.toString());
        print("Got event " + eventId.toString() + " successfully");
        print(data.statusCode);
        print(APIresult.result);
        return APIresult;
      } else {
        print("Getting event " + eventId.toString() + " failed");
        print(headers);
        print(data.statusCode);
        return null;
      }

    });

  }

  static void CancelEventById(int eventId) async {

    print("Calling API CancelEventById with eventId " + eventId.toString());

    token = StaticVariables.prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return http
        .put(StaticVariables.API + '/api/Client/Events/CancelEventById?eventId=$eventId',
        headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.toString());
        print("Cancelled event " + eventId.toString() + " successfully");
        print(data.statusCode);
        print(APIresult.result);
      } else {
        print("Cancelling event " + eventId.toString() + " failed");
        print(headers);
        print(data.statusCode);
      }

    });

  }

  static void SolveEventById(int eventId) async {

    print("Calling API SolveEventById with eventId " + eventId.toString());

    token = StaticVariables.prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return http
        .put(StaticVariables.API + '/api/Client/Events/SolveEventById?eventId=$eventId',
        headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.toString());
        print("Solved event " + eventId.toString() + " successfully");
        print(data.statusCode);
        print(APIresult.result);
      } else {
        print("Solving event " + eventId.toString() + " failed");
        print(headers);
        print(data.statusCode);
      }

    });

  }

  static Future<APIResponse<dynamic>> SendSOSRequest(int requestType) async {
    String jsonRequest = await GetSOSRequestJson(requestType);

    print("Calling API SolveSOS with request " + jsonRequest + " ..");

    SetActiveSOSRequestState("Searching");
    token = StaticVariables.prefs.getString('token');
    return http
        .post(StaticVariables.API + '/api/Client/SOS/SendSOSRequest',
            headers: headers, body: jsonRequest)
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.toString());
        print("Send SOS Success");
        print(data.statusCode);
        print(APIresult.result);
        var parsedJson = json.decode(APIresult.result);
        SetActiveSOSRequestState(parsedJson['requestStateName']);
        return APIresult;
      } else {
        print("Send SOS Failure");
        print(headers);

        print(data.statusCode);
      }

      return APIResponse<dynamic>(
          hasErrors: true,
          messages:
              "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits.");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true,
            messages:
                "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits."));
  }

  static Future<APIResponse<dynamic>> CancelSOSRequest(int requestID) async {
    //String jsonRequest = await GetSOSRequestJson(requestType);

    print(
        "Calling API CancelSOS with requestID " + requestID.toString() + " ..");

    SetActiveSOSRequestState("Cancelling");
    token = StaticVariables.prefs.getString('token');
    return http
        .put(StaticVariables.API + '/api/Client/SOS/CancelSOSRequest',
            headers: headers, body: requestID)
        .then((data) {
      if (data.statusCode == 200) {
        Map userMap = jsonDecode(data.body);
        var APIresult = APIResponse.fromJson(userMap);
        print(APIresult.toString());
        print("Cancel SOS SUCCESS");
        SetActiveSOSRequestState("Cancelled");
        print(APIresult.result);
//        var parsedJson = json.decode(APIresult.result);
//        prefs.setString("activerequeststate", parsedJson['requestStateName']);
        return APIresult;
      } else {
        print("Cancel SOS Failed");
        print(headers);

        print(data.statusCode);
      }

      return APIResponse<dynamic>(
          hasErrors: true,
          messages:
              "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits.");
    }).catchError((_) => APIResponse<dynamic>(
            hasErrors: true,
            messages:
                "Please make sure that:\n \n \n- Email is not taken and is correct.\n- Password is Complex. \n- National ID is 14 digits. \n- Phone Number is 11 digits."));
  }

  static Future<String> GetSOSRequestJson(int authorityType) async {
    String connID = StaticVariables.prefs.getString('connectionid_client');

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    String toReturn = "{ \"authorityType\": " + authorityType.toString();

    toReturn += ", \"longitude\": " + position.longitude.toString();

    toReturn += ", \"latitude\": " + position.latitude.toString();

    toReturn += ", \"connectionId\": \"" + connID + "\" }";

    return toReturn;
  }

  static Future<String> GetLastKnownLocationJson(Position newestLocation) async {

    GlobalVar.Set("lastsentlocation", newestLocation);

    String toReturn = "{ \"latitude\": " + newestLocation.latitude.toString();

    toReturn += ", \"longitude\": " + newestLocation.longitude.toString() + "}";

    return toReturn;
  }

  static void UpdateUserSOSState(List<Object> args) {
    print("Server sent UpdateUserSOSState with: requestID " +
        args[0].toString() +
        " and state: " +
        args[1].toString());
    StaticVariables.prefs
        .setString("sosrequest_" + args[0].toString(), args[1].toString());
    StaticVariables.prefs.setInt("activerequestid", args[0]);
    SetActiveSOSRequestState(args[1]);
  }

  //#endregion

  static void StartSharingLocation(
      String functionName, int longitude, int latitude) {
    _hubConnection.invoke(functionName,
        args: <Object>["0101", "1010", longitude, latitude]);
  }

  static Map<String, String> GetFormattedMap(String long, String lat) {
    Map<String, String> mapString = new Map<String, String>();

    mapString.putIfAbsent("longitude", () => long);
    mapString.putIfAbsent("latitude", () => lat);

    return mapString;
  }

  static Future<String> getAccessToken() async {
    String token = StaticVariables.prefs.getString('token');

    return token;
  }
}

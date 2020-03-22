import 'dart:convert';
import 'package:signalr_client/signalr_client.dart';

class SocketHandler
{

  static const kChatServerUrl = "http://192.168.1.5:5566/Realtime";

  static bool connectionIsOpen = false;
  static HubConnection _hubConnection;

  static Future<void> ConnectSocket() async
  {

    print("Trying to connect to server..");

    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder().withUrl(kChatServerUrl).build();
      _hubConnection.onclose((error) => connectionIsOpen = false);
      _hubConnection.on("LOCATION_GROUP_NAME", LOCATION_GROUP_NAME);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
      print("Connected!");
      connectionIsOpen = true;
      StartSharingLocation("START_LOCATION_SHARING", 11, 15);
    }

  }

  static void LOCATION_GROUP_NAME(List<Object> args)
  {

    print("Joined a location group! group name is " + args[0]);

  }

  static void StartSharingLocation(String functionName, int longitude, int latitude) {

    _hubConnection.invoke(functionName, args: <Object>["0101", "1010", longitude, latitude] );

  }

  static Map<String, String> GetFormattedMap(String long, String lat)
  {

    Map<String, String> mapString = new Map<String, String>();

    mapString.putIfAbsent("longitude", () => long);
    mapString.putIfAbsent("latitude", () => lat);

    return mapString;

  }

}
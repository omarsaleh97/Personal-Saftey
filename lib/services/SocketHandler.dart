import 'dart:io';
import 'dart:convert';

class SocketHandler
{

  static Socket socket;

  static void ConnectSocket(int port) async
  {

    socket = await Socket.connect('192.168.1.5', port); //Replace with server IP
    print('Connected to server!');

    socket.listen((List<int> event) {
      HandleServerMessage(utf8.decode(event));
    });

    SendServerRequest("SHARELOCATION", GetFormattedMap("33", "34"));

  }

  static Map<String, String> GetFormattedMap(String long, String lat)
  {

    Map<String, String> mapString = new Map<String, String>();

    mapString.putIfAbsent("longitude", () => long);
    mapString.putIfAbsent("latitude", () => lat);

    return mapString;

  }

  static void SendServerRequest(String type, Object map)
  {

    Map<String, String> mapObject = map as Map<String, String>;

    String jsonString = "";

    jsonString = "{\"type\": \"" + type + "\", \"parameters\": ";

    jsonString += json.encode(mapObject) + "}";

    print("Sending to server: " + jsonString);

    socket.add(utf8.encode(jsonString));

  }

  static void HandleServerMessage(String serverMessage)
  {

    print("Got from server: " + serverMessage);

  }

}
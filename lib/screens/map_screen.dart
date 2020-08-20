import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/others/GlobalVar.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main_page.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final bool isSelecting;

  MapScreen({
    this.latitude,
    this.longitude,
    this.isSelecting = false,
  });

  State createState() => new _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  Timer timer, pinsTimer;

  void socketHandlerInit() async {
    await SocketHandler.ConnectToClientChannel();

    SocketHandler.JoinEventRoom(
        StaticVariables.prefs.getString("emailForQRCode"),
        GlobalVar.Get("eventid", 0));

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      SocketHandler.SendLocationToServer(
          StaticVariables.prefs.getString("emailForQRCode"),
          GlobalVar.Get("eventid", 0));
    });
  }

  static Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  EventGetterModel active_event;

  bool amIVoluteer = true;
  ShowDialog(String title, String text, String iconToShow, Color color) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(
                  title,
                  style: TextStyle(color: primaryColor),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: SvgPicture.asset(
                        iconToShow,
                        color: color,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(text, style: TextStyle(color: primaryColor)),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text('OK', style: TextStyle(color: primaryColor)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ));
                      })
                ],
              ),
            ));
  }

  @override
  void initState() {

    if (GlobalVar.Get("mapmode", "view") != "select")
    {

      active_event = StaticVariables.eventsList
          .firstWhere((e) => e.id == GlobalVar.Get("eventid", 0));

      amIVoluteer = active_event.userName !=
          GlobalVar.Get("profilemap", new Map())["result"]["fullName"].toString();

      print(
          "Opened map screen with map mode: " + GlobalVar.Get("mapmode", "view"));

      markers = new Map<MarkerId, Marker>();

      pinsTimer = Timer.periodic(const Duration(seconds: 1), (pinsTimer) {
        print("Looping over " +
            StaticVariables.pinsList.length.toString() +
            " pins to place on map");
        print("count before for loop: " + markers.length.toString());
        for (int i = 0; i < StaticVariables.pinsList.length; i++) {
          ServerPin sp = StaticVariables.pinsList.first;
          StaticVariables.pinsList.remove(sp);
          UpdatePin(sp.userEmail, sp.position, false);
          if ((sp.position.latitude == -2 && sp.position.longitude == -2) ||
              (sp.position.latitude == -1 && sp.position.longitude == -1)) {
            String text = "";
            String iconToShow = "";
            Color color;
            if (sp.position.latitude == -2 && sp.position.longitude == -2) {
              text = "The Victim has marked the event as Solved.";
              iconToShow = 'assets/images/check.svg';
              color = Colors.green;
            } else {
              text = "The Victim has cancelled the event.";
              iconToShow = 'assets/images/close.svg';
              color = Colors.red;
            }
            ShowDialog("Event has been Terminated.", text, iconToShow, color);
          }
        }
        print("count after for loop: " + markers.length.toString());
      });

      if (GlobalVar.Get("mapmode", "view") == "help" ||
          GlobalVar.Get("mapmode", "view") == "track") {
        socketHandlerInit();
      } else {
        StaticVariables.pinsList.add(new ServerPin(
            "default", new LatLng(widget.longitude, widget.latitude)));

        //UpdatePin("default", new LatLng(widget.longitude, widget.latitude), true);

      }

    }

    super.initState();
  }

  @override
  void dispose() {
    print("Disposing event page");

    try {
      print("Cancelling location sending timer..");
      try {
        timer.cancel();
        print(
            "Cancelled location sending timer successfully. Cancelling pins timer..");
      } catch (e) {
        print("Didn't cancel location timer.");
      }
      print("Cancelling pins timer..");
      pinsTimer.cancel();
      print("Cancelled pins timer.");
    } catch (e) {
      print("Couldn't stop timers. " + e.toString());
    }

    try {
      if (GlobalVar.Get("mapmode", "help") == "help" ||
          GlobalVar.Get("mapmode", "help") == "track") {
        SocketHandler.LeaveEventRoom(
            StaticVariables.prefs.getString("emailForQRCode"),
            GlobalVar.Get("eventid", 0));
      }

      SocketHandler.Disconnect();
    } catch (e) {
      print("Couldn't leave event room properly. " + e.toString());
    }

    super.dispose();
  }

  void UpdatePin(String userEmail, LatLng position, bool redMarker) async {
    MarkerId markerId = MarkerId(userEmail);

    final Marker marker = Marker(
        markerId: MarkerId(userEmail),
        position: position,
        icon: !redMarker
            ? await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'assets/images/car.png')
            : BitmapDescriptor.defaultMarkerWithHue(0.5)
        //icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/car.png')
        );

    print("Trying to add a marker with ID " + userEmail);
    print("Marker is red? " + (redMarker || userEmail == "default").toString());

    setState(() {
      bool exists = false;
      if (userEmail != StaticVariables.prefs.getString("emailForQRCode") &&
          !(redMarker || userEmail == "default")) {
        for (int i = 0; i < markers.length; i++) {
          if (markers.keys.elementAt(i).value == userEmail) {
            exists = true;
            continue;
          }
        }
      } else if (redMarker || userEmail == "default") {
        print("Adding default red marker at " +
            position.longitude.toString() +
            " and " +
            position.latitude.toString());
        markers.putIfAbsent(markerId, () => marker);
        print("markers count now: " + markers.length.toString());
      }

      if (userEmail != StaticVariables.prefs.getString("emailForQRCode")) {
        if (!exists && !(redMarker || userEmail == "default")) {
          print("Adding a new pin for a new user " + userEmail);
          print("markers before: " + markers.length.toString());
          markers.putIfAbsent(markerId, () => marker);
          print("markers count after: " + markers.length.toString());
        } else {
          print("Updating pin for an existing user " + userEmail);
          markers[markerId] = marker;
        }
      } else {
        if (redMarker) {
          print("Adding a red marker..");
          markers.putIfAbsent(markerId, () => marker);
          markers[markerId] = marker;
        }
      }
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        centerTitle: true,
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(.1),
        title: Text(
          'Track',
          style: TextStyle(color: Colors.grey),
        ),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              color: grey,
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        // ignore: sdk_version_ui_as_code
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.latitude,
            widget.longitude,
          ),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (GlobalVar.Get("mapmode", "view") == "view" || GlobalVar.Get("mapmode", "view") == "select" )
            ? (_pickedLocation == null && widget.isSelecting)
                ? null
                : {
                    Marker(
                      markerId: MarkerId('m1'),
                      position: _pickedLocation ??
                          LatLng(
                            widget.latitude,
                            widget.longitude,
                          ),
                    ),
                  }
            : Set<Marker>.of(markers.values),
        trafficEnabled: true,
        scrollGesturesEnabled: true,
        myLocationEnabled: true,
        indoorViewEnabled: true,
      ),
      floatingActionButton: Visibility(
        visible: !amIVoluteer,
        child: FloatingActionButton.extended(
          heroTag: 'btn',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.camera_enhance,
                              color: Colors.white,
                              size: 40,
                            ),
                            radius: 30,
                            backgroundColor: grey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            GlobalVar.Get("profilemap", new Map())["result"]
                                    ["fullName"]
                                .toString(),
                            style: TextStyle(color: primaryColor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email',
                              style:
                                  TextStyle(fontSize: 15, color: primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              StaticVariables.prefs.getString("emailForQRCode"),
                              style: TextStyle(fontSize: 12, color: grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone Number',
                              style:
                                  TextStyle(fontSize: 15, color: primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              GlobalVar.Get("profilemap", new Map())["result"]
                                      ["phoneNumber"]
                                  .toString(),
                              style: TextStyle(fontSize: 12, color: grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Blood Type',
                              style:
                                  TextStyle(fontSize: 15, color: primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              GlobalVar.Get("profilemap", new Map())["result"]
                                      ["bloodType"]
                                  .toString(),
                              style: TextStyle(fontSize: 12, color: grey),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text(
                                (DateTime.now()
                                                .difference(DateTime.parse(
                                                    GlobalVar.Get("profilemap",
                                                                    new Map())[
                                                                "result"]
                                                            ["birthday"]
                                                        .toString()))
                                                .inDays /
                                            365)
                                        .round()
                                        .toString() +
                                    ' Years',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: primaryColor, fontSize: 15),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      width: 0.5, color: primaryColor)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xff16B68F),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: !amIVoluteer,
                        child: RaisedButton(
                          onPressed: () {
                            SocketHandler.CancelEventById(
                                GlobalVar.Get("eventid", 0));
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                          },
                          color: Accent2,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Cancel Event',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          label: Icon(
            Icons.info_outline,
            color: primaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}

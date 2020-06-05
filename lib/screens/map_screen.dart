import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/others/GlobalVar.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/widgets/drawer.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final bool isSelecting;

  MapScreen({
    this.latitude,
    this.longitude,
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();


  static void SetUserPin(String userEmail, LatLng position)
  {

    //TODO: Set a pin on map for that userEmail, use LatLng position

  }

}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  @override
  void initState() async {
    super.initState();

    await SocketHandler.ConnectToClientChannel();

    SocketHandler.JoinEventRoom("test@test.com", GlobalVar.Get("eventid", 0)); //TODO: Actually retrieve userEmail

    Timer timer;

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {

      SocketHandler.SendLocationToServer("test@test.com", GlobalVar.Get("eventid", 0)); //TODO: Actually retrieve userEmail

    });

  }

  @override
  void dispose() {

    print("Disposing event page");

    SocketHandler.LeaveEventRoom("test@test.com", GlobalVar.Get("eventid", 0)); //TODO: Actually retrieve userEmail

    SocketHandler.Disconnect();

    super.dispose();

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
      drawer: AppDrawer(),
      appBar: AppBar(
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
        zoomGesturesEnabled: false,
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
        markers: (_pickedLocation == null && widget.isSelecting)
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
              },
        trafficEnabled: true,
        scrollGesturesEnabled: true,
        myLocationEnabled: true,
        indoorViewEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
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
                          'Joan Doe',
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
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'alexa@test.com',
                            style: TextStyle(fontSize: 12, color: grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '01000002252',
                            style: TextStyle(fontSize: 12, color: grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Blood Type',
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'A+',
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
                              '23 Years',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: primaryColor, fontSize: 15),
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
                    child: RaisedButton(
                      onPressed: () {},
                      color: Accent2,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Cancel Event',
                        style: TextStyle(color: Colors.white),
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
    );
  }
}
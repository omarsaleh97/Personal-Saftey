import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:personal_safety/communication/android_communication.dart';
import 'package:personal_safety/componants/authority_card.dart';
import 'package:personal_safety/componants/authority_data.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/utils/AndroidCall.dart';
import 'package:personal_safety/utils/LatLngWrapper.dart';
import 'dart:async';

import '../componants/color.dart';
import '../componants/mediaQuery.dart';
import '../others/StaticVariables.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:math';

import 'news.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{

  static const methodChannel = const MethodChannel(METHOD_CHANNEL);
  bool isTrackingEnabled = false;
  bool isServiceBounded = false;
  List<LatLng> latLngList = [];
  final Set<Polyline> _polylines = {};
  AndroidCommunication androidCommunication = AndroidCommunication();

  GoogleMapController googleMapController;

  LatLng _center = const LatLng(45.521563, -122.677433);


  @override
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _authorityWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context) * 2,
      height: AppTheme.fullWidth(context) * .6,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: .8,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20),
          padding: EdgeInsets.only(left: 20),
          scrollDirection: Axis.horizontal,
          children:
          AuthorityData.AuthorityList.map((authority) => AuthorityCard(
            authority: authority,
          )).toList()),
    );
  }

  void _makeNewEvent() async{
    News save = await Navigator.of(context).push(new MaterialPageRoute<News>(
        builder: (BuildContext context) {
          return new AddEventScreen();
        },
        fullscreenDialog: true
    ));
    if (save != null) {
      // _addWeightSave(save);
    }
  }

  Widget _newPublicEvent() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              //height: 70,
                width: 150,
                alignment: Alignment.center,
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.all(Radius.circular(10))),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  onPressed:(){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventScreen()));
                    _makeNewEvent();
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "New Public Event...",
                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.add,color: Colors.black,size: 15,)
                    ],
                  ),
                  color: Accent2,
                )),
          ),
          SizedBox(width: 10),
          _icon(
            Icons.camera_alt,
            color: greyIcon,
          ),
          _icon(
            Icons.public,
            color: greyIcon,
          ),
          _icon(
            Icons.edit,
            color: greyIcon,
          ),
        ],
      ),
    );
  }

  Widget _topStories() {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(13)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Top Stories Nearby",
                  style: TextStyle(color: primaryColor, fontSize: 15),
                ),
              ),
              Flexible(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          color: grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _authorityWidget(),
              _newPublicEvent(),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    _topStories(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {

    super.initState();

    _setAndroidMethodCallHandler();

    _invokeServiceInAndroid();

  }

  void _onMapCreated(GoogleMapController googleMapController) {
    this.googleMapController = googleMapController;
  }

  void _invokeServiceInAndroid() {
    androidCommunication.invokeServiceInAndroid().then((onValue) {
      setState(() {
        isTrackingEnabled = true;
      });
    });
  }

  void _stopServiceInAndroid() {
    androidCommunication.stopServiceInAndroid().then((onValue) {
      setState(() {
        isTrackingEnabled = false;
      });
    });
  }

  Future _isPetTrackingEnabled() async {
    if (Platform.isAndroid) {
      bool result = await methodChannel.invokeMethod("isPetTrackingEnabled");
      setState(() {
        isTrackingEnabled = result;
      });
      debugPrint("Pet Tracking Status - $isTrackingEnabled");
    }
  }

  Future _isServiceBound() async {
    if (Platform.isAndroid) {
      debugPrint("ServiceBound Called from init");
      bool result = await methodChannel.invokeMethod("serviceBound");
      debugPrint("Result from ServiceBound call - $result");
      setState(() {
        isServiceBounded = result;
        if (isServiceBounded) {
          _isPetTrackingEnabled();
        }
      });
      debugPrint("Pet Tracking Status - $isTrackingEnabled");
    }
  }

  Future<dynamic> _androidMethodCallHandler(MethodCall call) async {
    switch (call.method) {
      case AndroidCall.PATH_LOCATION:
        var pathLocation = jsonDecode(call.arguments);
        LatLng latLng = LatLngWrapper.fromAndroidJson(pathLocation);
        latLngList.add(latLng);
        if (latLngList.isNotEmpty) {
          setState(() {
            if (latLngList.length > 2) {
              var bounds = LatLngBounds(
                  southwest: latLngList.first, northeast: latLngList.last);
              var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 25.0);
              googleMapController.animateCamera(cameraUpdate);
            }
            _polylines.add(Polyline(
              polylineId: PolylineId(latLngList.first.toString()),
              visible: true,
              points: latLngList,
              color: Colors.green,
              width: 2,
            ));
            _center = latLngList.last;
          });
        }
        debugPrint("Wrapper here --> $latLng");

        print("Called SendLocationToServer from native Android code.");
        //SocketHandler.SendLocationToServer(latLng.latitude, latLng.longitude);
        break;

    }
  }

  void _setAndroidMethodCallHandler() {
    methodChannel.setMethodCallHandler(_androidMethodCallHandler);
  }

  //-------------------------------------------------------------------------------

  int circle1Radius = 110, circle2Radius = 130, circle3Radius = 150;

  AnimationController _circle1FadeController, _circle1SizeController;
  Animation<double> _radiusAnimation, _fadeAnimation;

  String clientName = "Walter White", clientEmail = "Heisenberg@ABQ.com",
      clientPhoneNumber = "01000000991", clientBloodType = "A+",
      clientMedicalHistory = "Lung Cancer",
      clientHomeAddress = "308 Negra Arroyo Lane, Albuquerque,"
          " New Mexico, 87104";

  int clientAge = 51;

  Timer periodicalTimer;

  @override
  void dispose() {
    // Never called
    print("Disposing search page");
    _circle1FadeController.dispose();
    _circle1SizeController.dispose();
    super.dispose();

  }

}
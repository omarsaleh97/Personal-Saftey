import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:personal_safety/componants/authority_card.dart';
import 'package:personal_safety/componants/authority_data.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/screens/profilePage.dart';
import 'package:personal_safety/widgets/drawer.dart';

import '../communication/android_communication.dart';
import '../services/SocketHandler.dart';
import '../utils/AndroidCall.dart';
import '../utils/LatLngWrapper.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const methodChannel = const MethodChannel(METHOD_CHANNEL);
  bool isTrackingEnabled = false;
  bool isServiceBounded = false;
  List<LatLng> latLngList = [];
  final Set<Polyline> _polylines = {};
  AndroidCommunication androidCommunication = AndroidCommunication();

  GoogleMapController googleMapController;

  LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget _authorityWidget() {
    return Container(
      color: grey2.withOpacity(0.5),
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

  Widget _title() {
    return Container(
        // color: grey2.withOpacity(0.5),
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: 'Personal Safety',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: 'Lanuch a quick request below',
                  fontSize: 15,
                  color: greyIcon,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
          ],
        ));
  }

  Widget _coronaHelp() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white70,
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height *.325,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'COVID-19 Outreach',
                        style: TextStyle(
                            color: Color(0xff00688C),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              'Plan your path while trying to buy\n some groceries or'
                              ' attempting to\n pick up your family members.\n'
                              ' Stay and only Leave Your \n Home it is absolutely necessary',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 130,
                                height: 40,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  color: Color(0xff0F9DCA),
                                  onPressed: () {},
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  width: 100,
                                  height: 100,
                                  child: SvgPicture.asset(
                                      'assets/images/coronavirus.svg'))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height *.34,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Help Others',
                            style: TextStyle(
                                color: Color(0xff00688C),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Events()));
                            },
                            color: Color(0xff00688C),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              'Head to the news section and find someone\nin need of your help.Make your \n'
                              ' neighborhood safe and increase\n'
                              ' your rate',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Color(0xff006C8E),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'RATED 4.4 ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  width: 100,
                                  height: 100,
                                  child: SvgPicture.asset(
                                      'assets/images/voice_assistant.svg'))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  @override
  void initState() {
    super.initState();

    SocketHandler.Disconnect();

    _setAndroidMethodCallHandler();

    _invokeServiceInAndroid();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2.withOpacity(0.5),
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            color: Colors.grey,
          ),
        ],
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        elevation: 0.0,
        backgroundColor: grey2.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
          child: Container(
        color: grey2.withOpacity(0.5),
        height: MediaQuery.of(context).size.height * 1.028,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _title(),
            _authorityWidget(),
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _coronaHelp(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

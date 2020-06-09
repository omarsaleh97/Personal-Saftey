import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:personal_safety/communication/android_communication.dart';
import 'package:personal_safety/componants/authority_card.dart';
import 'package:personal_safety/componants/authority_data.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/models/device_token_update.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/screens/profilePage.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/services/get_profile_service.dart';
import 'package:personal_safety/services/update_device_token.dart';
import 'package:personal_safety/utils/AndroidCall.dart';
import 'package:personal_safety/utils/LatLngWrapper.dart';
import 'package:personal_safety/widgets/drawer.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UpdateDeviceTokenService get userService =>
      GetIt.instance<UpdateDeviceTokenService>();
  void updateRegistrationToken() async {
    _fcm.getToken().then((token) async {
      DeviceToken deviceToken = new DeviceToken(deviceRegistrationKey: token);

      print(token);
      StaticVariables.prefs.setString("fcmToken", token);
      StaticVariables.prefs.getString("fcmToken");

      final result = await userService.updateDeviceToken(deviceToken);
      debugPrint("from UPDATE TOKEN: " + result.status.toString());
      debugPrint("from UPDATE TOKEN: " + result.result.toString());
      debugPrint("from UPDATE TOKEN: " + result.hasErrors.toString());
    });
  }

  static const methodChannel = const MethodChannel(METHOD_CHANNEL);
  bool isTrackingEnabled = false;
  bool isServiceBounded = false;
  List<LatLng> latLngList = [];
  final Set<Polyline> _polylines = {};
  AndroidCommunication androidCommunication = AndroidCommunication();

  GoogleMapController googleMapController;

  LatLng _center = const LatLng(45.521563, -122.677433);

  final FirebaseMessaging _fcm = FirebaseMessaging();
  GetProfileService get profileService => GetIt.instance<GetProfileService>();
  @override
  void initState() {

    _setAndroidMethodCallHandler();
    _invokeServiceInAndroid();

    SocketHandler.StartSendingLocation();
    profileService.getProfile();
    _fcm.autoInitEnabled();
    updateRegistrationToken();
    _fcm.getToken().then((token) {
      print(token);
      StaticVariables.prefs.setString("fcmToken", token);
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        var data = message['data'];
        print("onMessage: $data");
        final snackbar = SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
            label: 'Go',
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Events())),
          ),
        );

        Scaffold.of(context).showSnackBar(snackbar);
//        showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//            content: ListTile(
//              title: Text(message['notification']['title']),
//              subtitle: Text(message['notification']['body']),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                color: Colors.amber,
//                child: Text('Ok'),
//                onPressed: () => Navigator.of(context).pop(),
//              ),
//            ],
//          ),
//        );
      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );
    super.initState();
  }

  void _setAndroidMethodCallHandler() {
    methodChannel.setMethodCallHandler(_androidMethodCallHandler);
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
        SocketHandler.TrySendingLocation();
        break;

    }
  }


  void _invokeServiceInAndroid() {
    androidCommunication.invokeServiceInAndroid().then((onValue) {
      setState(() {
        isTrackingEnabled = true;
      });
    });
  }

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2.withOpacity(0.5),
      appBar: AppBar(
        leading: new Container(),
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

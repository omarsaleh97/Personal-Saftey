import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/others/GlobalVar.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/home.dart';
import 'package:personal_safety/screens/main_page.dart';
import 'package:personal_safety/screens/map_screen.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:personal_safety/widgets/image_viewer.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class EventDetailScreen extends StatefulWidget {
  final EventGetterModel data;

  EventDetailScreen({this.data});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool helpUserButtonVisibility;
  static EventGetterModel active_event;

  String addressToUse;
  Future<void> getLocationAsText(double latitude, double longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    try {
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      String part1 = first.subAdminArea.toString();
      String part2 = first.adminArea.toString();
      String returnedAddress = part1 + ", " + part2;
      setState(() {
        addressToUse = returnedAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    GlobalVar.Set("eventid", widget.data.id);
    print(GlobalVar.Get("eventid", 0).toString());
    active_event = StaticVariables.eventsList
        .firstWhere((e) => e.id == GlobalVar.Get("eventid", 0));
    helpUserButtonVisibility = active_event.userName !=
        GlobalVar.Get("profilemap", new Map())["result"]["fullName"].toString();
    getLocationAsText(widget.data.latitude, widget.data.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final eventId = ModalRoute.of(context).settings.arguments; // is the id!
//    final loadedEvent = Provider.of<EventModel>(
//      context,
//      listen: false,
//    ).findById(data.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ImageViewer(data: widget.data.thumbnailUrl)));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Image(
                        image: NetworkImage(
                            "https://personalsafety.azurewebsites.net/${widget.data.thumbnailUrl}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),

                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.55,
                    decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.data.userName,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    addressToUse == null
                                        ? CustomLoadingIndicator(
                                            customColor: grey,
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6,
                                            child: Text(
                                              addressToUse,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                    Text(
                                      DateFormat('dd/MM/yyyy').add_jm().format(
                                          DateTime.parse(
                                              widget.data.lastModified)),
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '12',
                                        style: TextStyle(
                                            color: grey, fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: grey,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.data.title,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 150,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(widget.data.description),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColor),
                              child: FlatButton(
                                  onPressed: () {
                                    GlobalVar.Set("mapmode", "view");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => MapScreen(
                                                  latitude:
                                                      widget.data.latitude,
                                                  longitude:
                                                      widget.data.longitude,
                                                  isSelecting: false,
                                                )));
                                  },
                                  child: Text(
                                    'View in Map',
                                    style: TextStyle(color: Accent1),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: 220,
                              height: 50,
                              child: widget.data.isPublicHelp == true
                                  ? RaisedButton(
                                      color: Accent1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8),
                                      ),
                                      onPressed: () {
                                        print('tapped');
                                        GlobalVar.Set(
                                            "mapmode",
                                            helpUserButtonVisibility
                                                ? "help"
                                                : "track");
                                        helpUserButtonVisibility
                                            ? showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/postalert.svg',
                                                              width: 130,
                                                              height: 130,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Are you sure?',
                                                            style: TextStyle(
                                                                color: Accent1,
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'You are about to be involved in this event.\n'
                                                            'All your data will be shared with the user and\n the system adminstartion in case something \n goes wrong. You will always have access to\n the user\'s data',
                                                            style: TextStyle(
                                                              color: grey,
                                                              fontSize: 12,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                          ),
                                                          Container(
                                                            width: 180,
                                                            height: 45,
                                                            child: RaisedButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                        .circular(20),
                                                              ),
                                                              onPressed: () {
                                                                if (helpUserButtonVisibility) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          fullscreenDialog: true,
                                                                          builder: (context) => MapScreen(
                                                                                latitude: widget.data.latitude,
                                                                                longitude: widget.data.longitude,
                                                                                isSelecting: false,
                                                                              )));
                                                                }
                                                              },
                                                              color: Accent1,
                                                              child: Text(
                                                                'Proceed',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    fullscreenDialog: true,
                                                    builder: (context) =>
                                                        MapScreen(
                                                          latitude: widget
                                                              .data.latitude,
                                                          longitude: widget
                                                              .data.longitude,
                                                          isSelecting: false,
                                                        )));
                                      },
                                      child: Text(
                                        helpUserButtonVisibility
                                            ? 'HELP USER'
                                            : 'TRACK VOLUNTEERS',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ))
                                  : Container(),
                            ),
                          ),
                          Visibility(
                            visible:
                                !helpUserButtonVisibility, //TODO: Remove the "!"
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  child: RaisedButton(
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: IconButton(
                                                          icon:
                                                              Icon(Icons.close),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: SvgPicture.asset(
                                                          'assets/images/postalert.svg',
                                                          width: 130,
                                                          height: 130,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        'Are you sure?',
                                                        style: TextStyle(
                                                            color: Accent1,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        'You are about to mark this event as solved.\n'
                                                        'Event will disappear for all users.',
                                                        style: TextStyle(
                                                          color: grey,
                                                          fontSize: 12,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      Container(
                                                        width: 180,
                                                        height: 45,
                                                        child: RaisedButton(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(20),
                                                          ),
                                                          onPressed: () {
                                                            SocketHandler
                                                                .SolveEventById(
                                                                    GlobalVar.Get(
                                                                        "eventid",
                                                                        0));
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MainPage(),
                                                              ),
                                                            );
                                                          },
                                                          color: Accent1,
                                                          child: Text(
                                                            'Proceed',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ));
                                      },
                                      child: Text(
                                        'MARK AS SOLVED',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

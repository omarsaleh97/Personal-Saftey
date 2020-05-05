import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/map_screen.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  final NewEventData data;

  EventDetailScreen({this.data});
  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context).settings.arguments; // is the id!
    final loadedEvent = Provider.of<EventModel>(
      context,
      listen: false,
    ).findById(eventId);
    return Scaffold(
//        appBar: AppBar(
//          title: Text(
//            "Event Overview",
//            textScaleFactor: 1.2,
//            style: TextStyle(color: primaryColor),
//          ),
//          elevation: 0.0,
//          centerTitle: true,
//          backgroundColor: grey,
//        ),


      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                width: double.infinity,
                child: ClipRRect(
                    child: Image(
                  image: FileImage(data.image),
                  fit: BoxFit.cover,
                )),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),

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
                                  'USER NAME',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Tanta,EG",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "35 Years",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '12',
                                    style: TextStyle(color: grey, fontSize: 15),
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
                                'Event Details',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 200,
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
                                  child: Text(data.description),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: primaryColor
                          ),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => MapScreen(
                                              initialLocation: data.location,
                                              isSelecting: false,
                                            )));
                              },
                              child: Text('View in Map',style: TextStyle(color: Accent1),)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


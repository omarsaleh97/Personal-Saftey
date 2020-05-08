import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/events.dart';
import 'package:personal_safety/services/image_input.dart';
import 'package:personal_safety/services/location_input.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final EventDescription = TextEditingController();
  bool publicStatus = false;
  File _pickedImage;
  EventLocation _pickedLocation;

  bool descriptionFlag = false;
  bool imageFlag = false;
  bool locationFlag = false;

  @override
  void dispose() {
    EventDescription.dispose();
    super.dispose();
  }

  checkDetails() {
    final String description = EventDescription.text;
    final File image = _pickedImage;
    final EventLocation location = _pickedLocation;
    if (description.isEmpty) {
      descriptionFlag = false;
    } else {
      descriptionFlag = true;
    }

    if (image == null) {
      imageFlag = false;
    } else {
      imageFlag = true;
    }
    if (location == null) {
      locationFlag = false;
    } else {
      locationFlag = true;
    }
  }

  void onAdd() {
    final String description = EventDescription.text;
    final File image = _pickedImage;
    final EventLocation location = _pickedLocation;

    final bool public = publicStatus;

    if (description.isNotEmpty ||
        image == _pickedImage ||
        location == _pickedLocation) {
      final NewEventData event = NewEventData(
          image: _pickedImage,
          location: _pickedLocation,
          description: description,
          isPublic: public);

      Provider.of<EventModel>(context, listen: false).addEvent(event);
      Navigator.pop(context);
    }
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = EventLocation(latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Add Event'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLength: 120,
                        maxLines: 8,
                        showCursor: true,
                        cursorColor: primaryColor,
                        controller: EventDescription,
                        style: new TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Event Description",
                        ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    checkColor: Accent1,
                    activeColor: primaryColor,
                    value: publicStatus,
                    onChanged: (checked) => setState(() {
                      publicStatus = checked;
                    }),
                    title: Text('Make Event Public ?'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectPlace),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 70.0, bottom: 10, right: 70),
                    child: Container(
                      height: 50.0,
                      width: 300,
                      child: RaisedButton(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Accent1, fontSize: 20),
                          ),
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          onPressed: () async {
                            checkDetails();
                            if (descriptionFlag == true &&
                                imageFlag == true &&
                                locationFlag == true) {
                              print('tapped');
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                            Container(
                                              alignment: Alignment.topCenter,
                                              child: SvgPicture.asset(
                                                'assets/images/proceedalert.svg',
                                                width: 130,
                                                height: 130,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Confirm Ongoing Event',
                                              style: TextStyle(
                                                  color: Color(0xff006E90),
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'You are about to be post an ongoing event.\n'
                                              'where pepble near your neighborhood get\nnotified and can get involved to help you.Are\nyou sure you you want to continue?',
                                              style: TextStyle(
                                                color: grey,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Container(
                                              width: 180,
                                              height: 45,
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          20),
                                                ),
                                                onPressed: () {
                                                  onAdd();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Events()));
                                                },
                                                color: Color(0xff006E90),
                                                child: Text(
                                                  'Post',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: primaryColor,
                                                child: IconButton(
                                                  icon: Icon(Icons.close),
                                                  iconSize: 15,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Make sure the Description,Location And Image are valid",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ));
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

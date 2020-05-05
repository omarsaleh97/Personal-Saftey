import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/providers/event.dart';
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
  @override
  void dispose() {
    EventDescription.dispose();
    super.dispose();
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
                        onPressed: onAdd,
                      ),
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

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/event_categories.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/services/event_categories_service.dart';
import 'package:personal_safety/services/image_input.dart';
import 'package:personal_safety/services/location_input.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
  final List<EventCategories> eventCategoryData;
  AddEventScreen({this.eventCategoryData});
}

class EventCategory {
  int id;
  String category;
  EventCategory(this.id, this.category);
  static List<EventCategory> getCategory(
      List<EventCategories> eventCategories) {
    List<EventCategory> eventCategoriesList = List<EventCategory>();
    EventCategory eventCategoryElement = EventCategory(null, "Select Category");
    eventCategoriesList.add(eventCategoryElement);

    for (int i = 0; i < eventCategories.length; i++) {
      if (eventCategories[i].title == "Your Stories" ||
          eventCategories[i].title == "All Stories") {
      } else {
        EventCategory eventCategoryElement =
            EventCategory(eventCategories[i].id, eventCategories[i].title);

        eventCategoriesList.add(eventCategoryElement);
      }
    }
    return eventCategoriesList;
  }
}

class _AddEventScreenState extends State<AddEventScreen> {
  final EventDescription = TextEditingController();
  final titleController = TextEditingController();
  List<DropdownMenuItem<EventCategory>> _dropdownMenuItem;

  EventCategory _selectedEventCategory;

  bool publicStatus = false;
  File _pickedImage;
  EventLocation _pickedLocation;
  bool _isLoading = false;

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

////  void onAdd() {
//    final String description = EventDescription.text;
//    final File image = _pickedImage;
//    final EventLocation location = _pickedLocation;
//
//    final bool public = publicStatus;
//
//    if (description.isNotEmpty ||
//        image == _pickedImage ||
//        location == _pickedLocation) {
//      final NewEventData event = NewEventData(
//          image: _pickedImage,
//          location: _pickedLocation,
//          description: description,
//          isPublic: public);
//
//      Provider.of<EventModel>(context, listen: false).addEvent(event);
//      Navigator.pop(context);
//    }
//  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = EventLocation(latitude: lat, longitude: lng);
  }

  Dio dio = new Dio();
  String key;

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    key = prefs.getString('token');
  }

  @override
  void initState() {
    getToken();
    List<EventCategory> _eventCategory =
        EventCategory.getCategory(widget.eventCategoryData);
    _dropdownMenuItem = buildDropdownMenuItems(_eventCategory);
    _selectedEventCategory = _dropdownMenuItem[0].value;
    super.initState();
  }

  List<DropdownMenuItem<EventCategory>> buildDropdownMenuItems(
      List categories) {
    List<DropdownMenuItem<EventCategory>> items = List();
    for (EventCategory eventCategory in categories) {
      items.add(
        DropdownMenuItem(
          value: eventCategory,
          child: Text(eventCategory.category),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(EventCategory selectedCompany) {
    setState(() {
      _selectedEventCategory = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text('Add Event'),
        ),
        body: _isLoading == true
            ? Center(
                child: CustomLoadingIndicator(
                  customColor: primaryColor,
                ),
              )
            : ListView(
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
                                maxLength: 40,
                                maxLines: 1,
                                showCursor: true,
                                cursorColor: primaryColor,
                                controller: titleController,
                                style: new TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  errorBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: "Event Title",
                                ),
                              ),
                            ),
                          ),
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
                            title: Text('Make Event Public?'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton(
                            style: TextStyle(fontSize: 15, color: primaryColor),
                            itemHeight: 50,
                            items: _dropdownMenuItem,
                            onChanged: onChangeDropdownItem,
                            value: _selectedEventCategory,
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
                                    style:
                                        TextStyle(color: Accent1, fontSize: 20),
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
                                          builder: (_) => _isLoading == true
                                              ? Center(
                                                  child: CustomLoadingIndicator(
                                                    customColor: primaryColor,
                                                  ),
                                                )
                                              : AlertDialog(
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
                                                            color: Color(
                                                                0xff006E90),
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            debugPrint(
                                                                'JUST POSTED FROM POST BUTTON IN ALERT');
                                                            setState(() async {
                                                              File image;
                                                              _isLoading = true;
                                                              if (_pickedImage !=
                                                                  null) {
                                                                setState(() {
                                                                  image =
                                                                      _pickedImage;
                                                                });

                                                                try {
                                                                  String
                                                                      filename =
                                                                      image.path
                                                                          .split(
                                                                              '/')
                                                                          .last;
                                                                  FormData
                                                                      formData =
                                                                      new FormData
                                                                          .fromMap({
                                                                    'Title':
                                                                        titleController
                                                                            .text,
                                                                    'Description':
                                                                        EventDescription
                                                                            .text,
                                                                    'EventCategoryId':
                                                                        _selectedEventCategory
                                                                            .id,
                                                                    'Longitude':
                                                                        _pickedLocation
                                                                            .longitude,
                                                                    'Latitude':
                                                                        _pickedLocation
                                                                            .latitude,
                                                                    'IsPublicHelp':
                                                                        publicStatus,
                                                                    'Thumbnail': await MultipartFile.fromFile(
                                                                        image
                                                                            .path,
                                                                        filename:
                                                                            filename,
                                                                        contentType: new MediaType(
                                                                            'image',
                                                                            'png')),
                                                                    "type":
                                                                        "image/png"
                                                                  });
                                                                  Response response = await dio
                                                                      .post(
                                                                          "https://personalsafety.azurewebsites.net//api/Client/Events/PostEvent",
                                                                          data:
                                                                              formData,
                                                                          options:
                                                                              Options(headers: {
                                                                            'Content-Type':
                                                                                'multipart/form-data',
                                                                            'Authorization':
                                                                                'Bearer $key'
                                                                          }))
                                                                      .whenComplete(
                                                                          () {
                                                                    setState(
                                                                        () {
                                                                      _isLoading =
                                                                          false;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                } catch (e) {
                                                                  print(e);
                                                                }
                                                              }
                                                            });
                                                          },
                                                          color:
                                                              Color(0xff006E90),
                                                          child: Text(
                                                            'Post',
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
                                    } else {
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
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            primaryColor,
                                                        child: IconButton(
                                                          icon:
                                                              Icon(Icons.close),
                                                          iconSize: 15,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
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
                                                      textAlign:
                                                          TextAlign.center,
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
      ),
    );
  }
}

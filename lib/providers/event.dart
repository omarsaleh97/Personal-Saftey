import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/services/location_helper.dart';



class EventModel extends ChangeNotifier {
  final List<NewEventData> _events = [];
  List<NewEventData> get events {
    return [..._events];}

  UnmodifiableListView<NewEventData> get allEvents => UnmodifiableListView(_events);
  UnmodifiableListView<NewEventData> get nearbyEvent=>
      UnmodifiableListView(_events.where((ev) => !ev.isPublic));
  UnmodifiableListView<NewEventData> get publicEvent =>
      UnmodifiableListView(_events.where((ev) => ev.isPublic));

  void addEvent(NewEventData event) {
    _events.add(event);
    notifyListeners();
  }

  NewEventData findById(String id) {
    return _events.firstWhere((event) => event.id == id);
  }

  void toggleEvent(NewEventData event) {
    final taskIndex = _events.indexOf(event);
    _events[taskIndex].togglePublic();
    notifyListeners();
  }

  void deleteEvent(NewEventData event) {
    _events.remove(event);
    notifyListeners();
  }



//  Future<void> addEvent(
//      String pickedDescription,
//      File pickedImage,
//      EventLocation pickedLocation,
//      )
//
//
//
//  async {
//    final address = await LocationHelper.getEventAddress(
//        pickedLocation.latitude, pickedLocation.longitude);
//    final updatedLocation = EventLocation(
//      latitude: pickedLocation.latitude,
//      longitude: pickedLocation.longitude,
//      address: address,
//    );
//    final newEvent = NewEventData(
//      id: DateTime.now().toString(),
//      image: pickedImage,
//      description: pickedDescription,
//      location: updatedLocation,
//    );
//    _events.add(newEvent);
//    notifyListeners();
//
//  }


}
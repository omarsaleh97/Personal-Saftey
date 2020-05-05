import 'dart:io';

import 'package:flutter/material.dart';

class EventLocation {
  final double latitude;
  final double longitude;
  final String address;

  const EventLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class NewEventData {
  final String id;
  final DateTime dateTime;
  bool isPublic;
  bool isFav;
  final String description;
  final File image;
  final EventLocation location;

  NewEventData(
      {this.id,
      @required this.image,
      @required this.location,
      this.dateTime,
      @required this.description,
      this.isPublic = false,
      this.isFav = false});

  void togglePublic() {
    isPublic = !isPublic;
  }

  void toggleFavoriteStatus() {
    isFav = !isFav;
  }
}

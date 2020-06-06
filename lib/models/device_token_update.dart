import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DeviceToken {
  String deviceRegistrationKey;

  DeviceToken({@required this.deviceRegistrationKey});

  Map<String, dynamic> toJson() {
    return {
      "deviceRegistrationKey": deviceRegistrationKey,
    };
  }
}

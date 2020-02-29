import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ConfirmTokenCredentials {
  String token;

  ConfirmTokenCredentials({ @required this.token});

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}

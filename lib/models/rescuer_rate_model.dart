import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class RateRescuerModel {
  int requestID;
  int rescuerRate;

  RateRescuerModel({@required this.requestID, @required this.rescuerRate});

  Map<String, dynamic> toJson() {
    return {
      "requestID": requestID,
      "rescuerRate": rescuerRate,
    };
  }
}

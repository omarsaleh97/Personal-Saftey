import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ConfirmMailCredentials {
  String email;
  //String otp;

  ConfirmMailCredentials({
    @required this.email,
    /*@required this.otp*/
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      //"token": otp,
    };
  }
}

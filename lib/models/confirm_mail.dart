import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ConfirmMailCredentials {
  String email;
  String token;

  ConfirmMailCredentials({@required this.email, @required this.token});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token": token,
    };
  }
}

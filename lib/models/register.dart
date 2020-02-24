import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class RegisterCredentials {
  String fullName;
  String email;
  String nationalId;
  String phoneNumber;
  String password;

  RegisterCredentials(
      {@required this.fullName,
      @required this.email,
      @required this.password,
      @required this.nationalId,
      @required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "password": password,
      "nationalId": nationalId,
      "phoneNumber": phoneNumber
    };
  }
}

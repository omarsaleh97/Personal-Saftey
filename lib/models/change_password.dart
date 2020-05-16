import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordCredentials {
  String oldPassword;
  String newPassword;

  ChangePasswordCredentials({
    @required this.oldPassword,
    @required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
  }
}

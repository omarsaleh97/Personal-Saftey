import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class RefreshTokenCredentials {
  String token;
  String refreshToken;

  RefreshTokenCredentials({@required this.token, @required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "refreshToken": refreshToken,
    };
  }
}

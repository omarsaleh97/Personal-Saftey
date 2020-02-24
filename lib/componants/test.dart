import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/login.dart';

class Test extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Test> {
  String _token = "";
  @override
  void initState() {
    getTokenPreference().then(_updateToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Test Page'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new Text(
              _token,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  void _updateToken(String token) {
    setState(() {
      this._token = token;
    });
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Test extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Test> {
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  void initState() {
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
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                _save("0");
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Logout()));
              },
            )
          ],
        ),
      ),
    );
  }
}

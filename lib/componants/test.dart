import 'package:flutter/material.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/all_events.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  String token;
  @override
  void initState() {
    super.initState();
    setState(() {
      token = StaticVariables.prefs.getString("fcmToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SelectableText(
        token,
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/all_events.dart';

class News extends StatefulWidget {
  final String title;

  News({Key key, this.title}) : super(key: key);
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

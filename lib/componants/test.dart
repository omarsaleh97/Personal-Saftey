import 'package:flutter/material.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/all_events.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEventScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'NearBy Event'),
            Tab(text: 'Public Event'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
//          AllEventsTab(),
//          NearbyEvent(),
//          PublicEvents(),
        ],
      ),
    );
  }
}

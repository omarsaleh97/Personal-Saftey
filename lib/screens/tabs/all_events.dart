import 'package:flutter/material.dart';
import 'package:personal_safety/models/event_type_model.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/widgets/event_list.dart';
import 'package:provider/provider.dart';

class AllEventsTab extends StatefulWidget {
  Story data;

  AllEventsTab({this.data});

  @override
  _AllEventsTabState createState() => _AllEventsTabState();
}

class _AllEventsTabState extends State<AllEventsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Consumer<EventModel>(
          builder: (context, events, child) => EventList(
            events: events.allEvents,
          ),
        ),
      ),
    );
  }
}

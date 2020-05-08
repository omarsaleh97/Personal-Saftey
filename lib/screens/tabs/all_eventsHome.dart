import 'package:flutter/material.dart';
import 'package:personal_safety/models/event_type_model.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/widgets/event_list.dart';
import 'package:provider/provider.dart';

class AllEventsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Consumer<EventModel>(
          builder: (context, events, child) => EventList(
            events: events.allEvents,
          ),
        ),
      ),
    );
  }
}

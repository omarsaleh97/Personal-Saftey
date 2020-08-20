import 'package:flutter/material.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/widgets/event_list_item.dart';

class EventList extends StatelessWidget {
  final List<NewEventData> events;

  EventList({@required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getEvents(),
    );
  }

  List<Widget> getEvents() {
//    return events.map((ev) => EventListItem(eventGetter: ev,)).toList();
  }
}

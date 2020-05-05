import 'package:flutter/material.dart';
import 'package:personal_safety/models/event_type_model.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/widgets/event_list.dart';
import 'package:provider/provider.dart';

class NearbyEvent extends StatelessWidget {
  Story data;

  NearbyEvent({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width / 1.4,
                width: double.infinity,
                child: ClipRRect(
                    child: Image(
                  image: data.image,
                  fit: BoxFit.cover,
                )),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),

                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: MediaQuery.of(context).size.width * 1.5,
                  child: Consumer<EventModel>(
                    builder: (context, event, child) => EventList(
                      events: event.nearbyEvent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

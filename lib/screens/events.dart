import 'package:flutter/material.dart';
import 'package:personal_safety/componants/EventStoriesData.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/componants/story_card.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/models/event_type_model.dart';

import 'package:personal_safety/screens/tabs/all_events.dart';
import 'package:personal_safety/widgets/drawer.dart';

class Events extends StatefulWidget {
  final String title;

  Events({Key key, this.title}) : super(key: key);
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events>{

  @override
  void initState() {
    super.initState();

  }


  Story story;

  Widget _storyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .35,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: .95,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20),
          padding: EdgeInsets.only(left: 20),
          scrollDirection: Axis.horizontal,
          children: EventStoriesData.StoryList.map((story) => StoryCard(
                story: story,
              )).toList()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: null,
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(),
            ),
          );
        },
      ),
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
            color: Colors.grey,
          ),
        ],
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        title: Text(
          "News & Events",
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(.1),

      ),
      body: Column(
        children: <Widget>[
          _storyWidget(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 500,
              child: AllEventsTab(),
            ),
          )
        ],
      ),
    );
  }
}

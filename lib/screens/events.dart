import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/componants/EventStoriesData.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/componants/story_card.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/models/event_categories.dart';
import 'package:personal_safety/models/event_type_model.dart';

import 'package:personal_safety/screens/tabs/all_events.dart';
import 'package:personal_safety/services/event_categories_service.dart';
import 'package:personal_safety/widgets/drawer.dart';

class Events extends StatefulWidget {
  final String title;

  Events({Key key, this.title}) : super(key: key);
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> with SingleTickerProviderStateMixin {
  TabController controller;
  List<EventCategories> eventCategories;
  EventCategoriesService get userService =>
      GetIt.instance<EventCategoriesService>();

  Future getCategories() async {
    final result = await userService.getEventCategories();
    print('OBTAINED CATEGORIES FROM SERVICE!!!!\n\n');
    setState(() {
      List<EventCategories> list = result.result;
      for (int i = 0; i < result.result.length; i++) {
        print("ITEM ${i + 1}: \n\n");
        print("ID: ${list[i].id}");
        print("TITLE: ${list[i].title}");
        print("THUMBNAIL: ${list[i].thumbnailUrl}");
        print("\nEND OF ITEM ${i + 1}\n \n");
      }
      print('OBTAINED CATEGORIES FROM SERVICE!!!!');
      eventCategories = list;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
    controller =
        TabController(length: EventStoriesData.StoryList.length, vsync: this);
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
//        bottom: TabBar(
//          controller: controller,
//          tabs: <Widget>[
//            Tab(text: 'All'),
//            Tab(text: 'Corona'),
//            Tab(text: 'Nearby'),
//          ],
//        ),
      ),
      body: eventCategories == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: AppTheme.fullWidth(context),
              height: AppTheme.fullWidth(context) * .35,
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: .95,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: eventCategories.length,
                itemBuilder: (context, index) => EventCard(
                  eventCategory: eventCategories[index],
                ),
              ),
            ),
//                  for (int i = 0; i < eventCetegories.length; i++)
//
//                  SingleChildScrollView(
//                    scrollDirection: Axis.vertical,
//                    child: Container(
//                      height: 500,
//                      child: AllEventsTab(),
//                    ),
//                  )
    );
  }
}

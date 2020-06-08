import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/componants/EventStoriesData.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/newEventDialog.dart';
import 'package:personal_safety/componants/story_card.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/models/event_categories.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/event_type_model.dart';

import 'package:personal_safety/screens/tabs/all_events.dart';
import 'package:personal_safety/services/event_categories_service.dart';
import 'package:personal_safety/services/getEvent_service.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:personal_safety/widgets/event_list.dart';
import 'package:personal_safety/widgets/event_list_item.dart';

class Events extends StatefulWidget {
  final String title;

  Events({
    Key key,
    this.title,
  }) : super(key: key);
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> with SingleTickerProviderStateMixin {
  TabController controller;
  List<EventCategories> eventCategories;
  List<EventGetterModel> events;
  EventCategoriesService get userService =>
      GetIt.instance<EventCategoriesService>();
  GetEventsService get eventService => GetIt.instance<GetEventsService>();

  Future getEventsAndCategories() async {
    eventCategories = null;
    events = null;
    final result2 = await eventService.getEvents();

    final result = await userService.getEventCategories();
    setState(() {
      print('OBTAINED EVENTS FROM SERVICE!!!!\n\n');
      List<EventGetterModel> list2 = result2.result;
      print('OBTAINED EVENTS FROM SERVICE!!!!');
      print('OBTAINED CATEGORIES FROM SERVICE!!!!\n\n');

      events = list2;
      List<EventCategories> list = result.result;
      print('OBTAINED CATEGORIES FROM SERVICE!!!!');
      eventCategories = list;
    });
  }

  @override
  void initState() {
    getEventsAndCategories();
    super.initState();
    controller =
        TabController(length: EventStoriesData.StoryList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: () {
            if (events != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEventScreen(
                    eventCategoryData: eventCategories,
                  ),
                ),
              ).whenComplete(getEventsAndCategories);
            } else {}
          },
        ),
      ),
      appBar: AppBar(
        leading: new Container(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                getEventsAndCategories();
              });
            },
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
      body: eventCategories == null || events == null
          ? Center(
              child: CustomLoadingIndicator(
              customColor: primaryColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
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
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: events.length,
                              itemBuilder: (context, index) => EventListItem(
                                    eventGetter: events[index],
                                  )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

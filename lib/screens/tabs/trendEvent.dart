import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/event_categories.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/event_type_model.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/services/getEvent_service.dart';
import 'package:personal_safety/widgets/event_list.dart';
import 'package:personal_safety/widgets/event_list_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendEvent extends StatefulWidget {
  @override
  _TrendEventState createState() => _TrendEventState();
  final EventCategories eventCategoryData;

  TrendEvent({this.eventCategoryData});
}

class _TrendEventState extends State<TrendEvent> {
  List<EventGetterModel> events;
  GetEventsService get eventService => GetIt.instance<GetEventsService>();

  Future getEventsCategories() async {
    final result2 = await eventService.getEvents();

    setState(() {
      print('EVENTS BY CATEGORY');
      List<EventGetterModel> list2 = result2.result;
      events = list2;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('categoryID', 0);
    print('EVENTS BY CATEGORY');
  }

  @override
  void initState() {
    getEventsCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .5,
                  child: ClipRRect(
                    child: Image(
                        image: NetworkImage(
                            "https://personalsafety.azurewebsites.net/${widget.eventCategoryData.thumbnailUrl}"),
                        fit: BoxFit.cover),
                  ),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),

                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          color: Colors.black26,
                          child: Text(
                            widget.eventCategoryData.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 31,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: events == null
                              ? Center(
                                  child: CustomLoadingIndicator(
                                    customColor: primaryColor,
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.67,
                                    child: ListView.builder(
                                        itemCount: events.length,
                                        itemBuilder: (context, index) =>
                                            EventListItem(
                                              eventGetter: events[index],
                                            )),
                                  ),
                                )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

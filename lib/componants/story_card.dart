import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/models/event_type_model.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/trendEvent.dart';
import 'package:personal_safety/models/event_categories.dart';
import 'package:personal_safety/services/event_categories_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personal_safety/others/StaticVariables.dart';

class StoryCard extends StatefulWidget {
  Story story;
  StoryCard({Key key, this.story}) : super(key: key);

  @override
  _StoryCardState createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  Story type;

  void initState() {
    type = widget.story;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EventCard();
  }
}

class EventCard extends StatefulWidget {
  EventCard({Key key, @required this.eventCategory}) : super(key: key);
  EventCategories eventCategory;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
//

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Story type;

    return Container(
      width: 100,
      height: 100,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        semanticContainer: true,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://personalsafety.azurewebsites.net/${widget.eventCategory.thumbnailUrl}"),
                fit: BoxFit.cover),
          ),
          child: InkWell(
              onTap: () async {
                debugPrint(
                    "ID from EVENT CATEGORY: ${widget.eventCategory.id}\n");
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('categoryID', widget.eventCategory.id);

                var id = prefs.getInt("categoryID");
                print('EVENT CATEGORY ID FOR SERVICE $id');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrendEvent(
                              eventCategoryData: widget.eventCategory,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 70),
                child: Container(
                  color: Colors.black26,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.eventCategory.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

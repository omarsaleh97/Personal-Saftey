import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/models/event_type_model.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/trendEvent.dart';

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
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      semanticContainer: true,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: type.image, fit: BoxFit.cover),
        ),
        child: InkWell(
            onTap: () {
              if(type.id==1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TrendEvent(data: type,)));
              }
              if(type.id==2){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyEvent(data: type,)));
              }
              if(type.id==3){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PublicEvents(data: type,)));
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 70),
                child: type.name,
            )),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

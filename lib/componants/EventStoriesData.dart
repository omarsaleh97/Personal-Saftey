import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/event_type_model.dart';

class EventStoriesData {
  static List<Story> StoryList = [
    Story(
      id: 1,
      name: Text(
        'Corona \nVirus',
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      image: AssetImage(
        'assets/images/corona2.jpg',
      ),
    ),
    Story(
      id: 2,
      name: Text(
        'Nearby \nStories',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      image: AssetImage('assets/images/corona2.jpg'),
    ),
    Story(
      id: 3,
      name: Text(
        'Your \nStories',
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      image: AssetImage('assets/images/corona2.jpg'),
    ),
    Story(
      id: 4,
      name: Text(
        'Your \nStories 2323',
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      image: AssetImage('assets/images/corona2.jpg'),
    ),
    Story(
      id: 5,
      name: Text(
        'his \nStories 2323',
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      image: AssetImage('assets/images/corona2.jpg'),
    )
  ];
}

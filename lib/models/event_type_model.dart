

import 'package:flutter/material.dart';

class Story {
  int id;
  Text name;
  AssetImage image;

  Story({
    this.image,this.name,this.id
  });
}

 List<Story> StoryList = [
  Story(
    id: 1,
    name: Text('Corona \nVirus',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
    image: AssetImage('assets/images/corona2.jpg',),

  ),
  Story(
    id: 2,
    name: Text('Nearby \nStories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,),),
    image: AssetImage('assets/images/corona2.jpg'),

  ),
  Story(
    id: 3,
    name: Text('Your \nStories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
    image: AssetImage('assets/images/corona2.jpg'),

  )
];
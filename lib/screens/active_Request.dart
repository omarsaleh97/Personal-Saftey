import 'package:flutter/material.dart';
import 'package:personal_safety/widgets/drawer.dart';

class ActiveRequest extends StatefulWidget {
  @override
  _ActiveRequestState createState() => _ActiveRequestState();
}

class _ActiveRequestState extends State<ActiveRequest> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
            },
            color: Colors.grey,
          ),
        ],
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        title: Text(
          "Active Request",
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(.1),

      ),

        );

  }
}
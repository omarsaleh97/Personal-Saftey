import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/widgets/drawer.dart';

class NearestFacilities extends StatefulWidget {
  NearestFacilities({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _NearestFacilitiesState createState() => _NearestFacilitiesState();
}

class _NearestFacilitiesState extends State<NearestFacilities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
            color: Colors.grey,
          ),
        ],
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        title: Text(
          "Nearby Facilities",
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(.1),
      ),
    );
  }
}

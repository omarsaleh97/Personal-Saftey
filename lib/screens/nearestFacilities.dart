import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';

class NearestFacilities extends StatefulWidget {

  NearestFacilities({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _NearestFacilitiesState createState() => _NearestFacilitiesState();
}

class _NearestFacilitiesState extends State<NearestFacilities> {

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: "Nearest Facilities",
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                ]
                ),
              ],
            ),

    );


  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _title()
      ],
    );
  }
}

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/componants/authority_card.dart';
import 'package:personal_safety/componants/authority_data.dart';
import 'package:personal_safety/componants/authority_icon.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'dart:math';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _authorityWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context) * 2,
      height: AppTheme.fullWidth(context) * .6,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: .8,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20),
          padding: EdgeInsets.only(left: 20),
          scrollDirection: Axis.horizontal,
          children:
              AuthorityData.AuthorityList.map((authority) => AuthorityCard(
                    authority: authority,
                  )).toList()),
    );
  }

  Widget _newPublicEvent() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "New Public Event...",
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          _icon(
            Icons.camera_alt,
            color: greyIcon,
          ),
          _icon(
            Icons.public,
            color: greyIcon,
          ),
          _icon(
            Icons.edit,
            color: greyIcon,
          ),
        ],
      ),
    );
  }

  Widget _topStories() {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(13)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Top Stories Nearby",
                  style: TextStyle(color: primaryColor, fontSize: 15),
                ),
              ),
              Flexible(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Five questions lawmarkers should ask Devos about teacher effectivness",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "1 hour ago",
                        style: TextStyle(
                            color: greyIcon, fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                          "assets/images/1.jpg",
                          width: 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          color: grey,
          child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          _authorityWidget(),
          _newPublicEvent(),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
               _topStories(),
              ],
            ),
          ),
      ],
    ),
        ));
  }
}

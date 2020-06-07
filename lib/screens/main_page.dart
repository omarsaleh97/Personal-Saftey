import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/screens/active_Request.dart';
import 'package:personal_safety/screens/home.dart';
import 'package:personal_safety/screens/nearestFacilities.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/screens/profilePage.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/all_events.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  bool isNearestPageSelected = true;
  bool isNewsPageSelected = true;
  bool isActiveRequestPageSelected = true;

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('Exit Application?', style: TextStyle(color: grey)),
            content: Text('You are going to exit the application.',
                style: TextStyle(color: grey)),
            actions: <Widget>[
              FlatButton(
                child: Text('NO', style: TextStyle(color: grey)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES', style: TextStyle(color: grey)),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }

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
                  text: isHomePageSelected
                      ? 'Personal Safety'
                      : isNearestPageSelected
                          ? 'Nearest Facilities'
                          : isActiveRequestPageSelected
                              ? 'Active Requests'
                              : "",
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text:
                      isHomePageSelected ? 'Lanuch a quick request below' : "",
                  fontSize: 15,
                  color: greyIcon,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0) {
      setState(() {
        isHomePageSelected = true;
        isNewsPageSelected = false;
        isNearestPageSelected = false;
        isActiveRequestPageSelected = false;
      });
    }

    if (index == 1) {
      setState(() {
        isHomePageSelected = false;
        isNewsPageSelected = false;
        isNearestPageSelected = false;
        isActiveRequestPageSelected = true;
      });
    }
    if (index == 2) {
      setState(() {
        isHomePageSelected = false;
        isNewsPageSelected = false;
        isNearestPageSelected = true;
        isActiveRequestPageSelected = false;
      });
    }
    if (index == 3) {
      setState(() {
        isHomePageSelected = false;
        isNewsPageSelected = true;
        isNearestPageSelected = false;
        isActiveRequestPageSelected = false;
      });
    }
  }

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  Widget get bottomNavBar {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: BottomNavigationBar(
        currentIndex: _cIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_cIndex == 0)
                      ? Colors.orange
                      : Color.fromARGB(255, 0, 0, 0)),
              title: new Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_important,
                  color: (_cIndex == 1)
                      ? Colors.orange
                      : Color.fromARGB(255, 0, 0, 0)),
              title: new Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on,
                  color: (_cIndex == 2)
                      ? Colors.orange
                      : Color.fromARGB(255, 0, 0, 0)),
              title: new Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.new_releases,
                  color: (_cIndex == 3)
                      ? Colors.orange
                      : Color.fromARGB(255, 0, 0, 0)),
              title: new Text(''))
        ],
        onTap: (index) {
          _incrementTab(index);
          onBottomIconPressed(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                height: AppTheme.fullHeight(context) - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: isHomePageSelected
                            ? Home()
                            : isNewsPageSelected
                                ? Events()
                                : isNearestPageSelected
                                    ? NearestFacilities()
                                    : isActiveRequestPageSelected
                                        ? ActiveRequest()
                                        : "")
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 10),
          child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 5)
              ]),
              child: bottomNavBar),
        ),
      ),
    );
  }
}

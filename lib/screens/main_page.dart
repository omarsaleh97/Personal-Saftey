import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/models/newEvent.dart';
import 'package:personal_safety/screens/active_Request.dart';
import 'package:personal_safety/screens/home.dart';
import 'package:personal_safety/screens/nearestFacilities.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/tabs/all_events.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title,this.data}) : super(key: key);
NewEventData data;
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
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application.'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () async {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: IconButton(
              icon: Icon(
                Icons.dehaze,
              ),
              color: Colors.black54,
              onPressed: () {
//                AppDrawer();
//                print("press");
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
                decoration: BoxDecoration(
                    color: greyIcon, borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () async {
                    //_save("0");
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('token');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Logout()));
                  },
                )),
          )
        ],
      ),
    );
  }

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
                              : isNewsPageSelected ? 'News' : "",
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
         appBar: AppBar(
           actions: <Widget>[
             ClipRRect(
               borderRadius: BorderRadius.all(Radius.circular(13)),
               child: IconButton(
                 icon: Icon(Icons.lock),
                 color: primaryColor,
                 onPressed: () async {
                   //_save("0");
                   SharedPreferences prefs =
                   await SharedPreferences.getInstance();
                   prefs.remove('token');
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => Logout()));
                 },
               ),
             )
           ],
               backgroundColor: grey,
           bottomOpacity: 0.0,

           elevation: 0.0,
         ),
        drawer: AppDrawer(),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: AppTheme.fullHeight(context) - 50,
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                    colors: [
//                      grey,
//                      grey2,
//                    ],
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                  )),
                  //  color: grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     // Container(color: grey, child: _appBar()),
                     Container(color: grey, child: _title()),
                      Expanded(
//                          child: AnimatedSwitcher(
//                              duration: Duration(milliseconds: 300),
//                              switchInCurve: Curves.easeInToLinear,
//                              switchOutCurve: Curves.easeOutBack,
//                              child: isHomePageSelected
//                                  ? Home()
//                                  : Align(
//                                      alignment: Alignment.topCenter,
//                                      //  child: ActiveRequest(),
//                                    ))
                          child: isHomePageSelected
                              ? Home(event: widget.data,)
                              : isNewsPageSelected
                                  ? News()
                                  : isNearestPageSelected
                                      ? NearestFacilities()
                                      : isActiveRequestPageSelected ? ActiveRequest() : "")
                    ],
                  ),
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

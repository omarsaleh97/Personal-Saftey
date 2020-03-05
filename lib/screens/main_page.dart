import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/componants/BottomNavBar/BottomNavBar.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/screens/active_Request.dart';
import 'package:personal_safety/screens/home.dart';
import 'package:personal_safety/screens/nearestFacilities.dart';
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
              onPressed: () {_drawer();},
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                  color: greyIcon, borderRadius: BorderRadius.circular(20)),
              child:        IconButton(
                icon: Icon(Icons.lock),
                onPressed: ()async {
                  //_save("0");
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Logout()));
                },
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: null,
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text("Log out"),
                leading: Icon(Icons.lock),
              ),
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    grey,
                    grey2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
                    _title(),
                    Expanded(
                        child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            switchInCurve: Curves.easeInToLinear,
                            switchOutCurve: Curves.easeOutBack,
                            child: isHomePageSelected
                                ? Home()
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: Logout(),
                                  )))
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: CustomBottomNavigationBar(
                  onIconPresedCallback: onBottomIconPressed,
                ))
          ],
        ),
      ),
    );
  }
}

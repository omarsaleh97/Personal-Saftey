import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/others/StaticVariables.dart';
import 'package:personal_safety/screens/home.dart';
import 'dart:async';

import 'package:personal_safety/services/SocketHandler.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
  
}

class _SearchState extends State<Search> with TickerProviderStateMixin {

  int circle1Radius = 110, circle2Radius = 130, circle3Radius = 150;

  AnimationController _circle1FadeController, _circle1SizeController;
  Animation<double> _radiusAnimation, _fadeAnimation;

  @override
  void dispose() {
    // Never called
    print("Disposing search page");
    _circle1FadeController.dispose();
    _circle1SizeController.dispose();
    super.dispose();
  }
  
  CancelAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Color(0xffFF2B56),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cancel Request",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "A facility operator was about to accept your request, Are you sure you want to cancel the pending request?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 50.0,
                      width: 200,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        onPressed: () async {
                          SocketHandler.CancelSOSRequest(StaticVariables.prefs.getInt("activerequestid"));
                          Navigator.pop(context);
//                          Navigator.pop(context);
                        },
                        child: Text(
                          "cancel",
                          style:
                              TextStyle(color: Color(0xffFF2B56), fontSize: 18),
                        ),
                      ))
                ],
              ),
            ],
          )),
    );
  }

  alertDialog() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: GetColorBasedOnState(),
        content: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      StaticVariables.prefs.getString("activerequeststate") == null? "Searching.." : StaticVariables.prefs.getString("activerequeststate"),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                Visibility(
                  visible: StaticVariables.prefs.getString("activerequeststate") != "Cancelled",
                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () {
                          CancelAlertDialog();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Find a near facility to help you out.",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    )),
              ],
            ),
          ],
        ));
  }

  @override
  void initState() {

    super.initState();

    Timer timer;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(StaticVariables.prefs.getString("activerequeststate") == "Cancelled") {
        timer.cancel();
      }
      DoSearchAnimation();
    });

  }

  double beginValue = 100, endValue = 150, beginFade = 1, endFade = 0.2, tmpValue, tmpValue2;
  
  Color GetColorBasedOnState()
  {

    Color toReturn = Color.fromRGBO(255, 43, 86, 1.0);

    if (StaticVariables.prefs == null)
        toReturn = Color.fromRGBO(255, 43, 86, 1.0); //Reddish
    else {

      String state = StaticVariables.prefs.getString("activerequeststate");

      switch(state)
      {

        case "Searching":

          toReturn = Color.fromRGBO(255, 43, 86, 1.0); //Reddish

          break;

        case "Cancelling":

          toReturn = Color.fromRGBO(244, 26, 26, 1.0); //Dark reddish

          break;

        case "Cancelled":

          toReturn = Color.fromRGBO(66, 66, 66, 1.0); //Dark grey

          break;

        case "Pending":

          toReturn = Color.fromRGBO(255, 174, 0, 1.0); //Orange

          break;

        case "Accepted":

          toReturn = Color.fromRGBO(30, 204, 18, 1.0); //Green

          break;

      }

    }

    return toReturn;

  }

  Color requestColor = Color.fromRGBO(255, 43, 86, 1.0);

  void DoSearchAnimation() async
  {

    if (StaticVariables.prefs.getString("activerequeststate") != "Cancelled") {
      _circle1FadeController = new AnimationController(duration: new Duration(
          milliseconds: 2000
      ),
          vsync: this);

      _circle1SizeController = new AnimationController(duration: new Duration(
          milliseconds: 2000
      ),
          vsync: this);

      _radiusAnimation =
          new Tween<double>(begin: beginValue, end: endValue).animate(
              new CurvedAnimation(curve: Curves.easeInSine,
                  parent: _circle1SizeController)
          );

      _fadeAnimation =
          new Tween<double>(begin: beginFade, end: endFade).animate(
              new CurvedAnimation(curve: Curves.easeInSine,
                  parent: _circle1FadeController)
          );

      _circle1SizeController.addListener(() {
        if (this.mounted) {
          this.setState(() {});
        }
      });

      _circle1FadeController.addListener(() {
        if (this.mounted) {
          this.setState(() {});
        }
      });

      _circle1FadeController.forward();
      _circle1SizeController.forward();

      tmpValue = beginValue;
      beginValue = endValue;
      endValue = tmpValue;

      tmpValue2 = beginFade;
      beginFade = endFade;
      endFade = tmpValue2;
    }

  }


  @override
  int _cIndex = 0;

  void _incrementTab(index) {
    if (this.mounted) {
      this.setState(() {});
    setState(() {
      _cIndex = index;
    });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                    child: CircleAvatar(
                      child: SvgPicture.asset(
                        "assets/images/place-24px.svg",
                        color: Colors.white,
                        width: 100,
                        height: 150,
                      ),
                      radius: _radiusAnimation == null? beginValue : _radiusAnimation.value,
                      backgroundColor: GetColorBasedOnState().withOpacity(_fadeAnimation == null? 1 : _fadeAnimation.value),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 580),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: alertDialog(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          },
        ));
  }
}

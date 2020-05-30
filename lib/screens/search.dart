import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/others/GlobalVar.dart';
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

    SocketHandler.Disconnect();

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
                          SocketHandler.CancelSOSRequest(
                              StaticVariables.prefs.getInt("activerequestid"));
                          Navigator.pop(context);
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
        contentPadding: EdgeInsets.all(30),
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
                      StaticVariables.prefs.getString("activerequeststate") ==
                              null
                          ? "Searching.."
                          : StaticVariables.prefs
                              .getString("activerequeststate"),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                Visibility(
                  visible:
                      StaticVariables.prefs.getString("activerequeststate") !=
                          "Cancelled",
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
      if (StaticVariables.prefs.getString("activerequeststate") ==
          "Cancelled") {
        timer.cancel();
      }
      DoSearchAnimation();
    });
  }

  double beginValue = 100,
      endValue = 150,
      beginFade = 1,
      endFade = 0.2,
      tmpValue,
      tmpValue2;

  Color GetColorBasedOnState() {
    Color toReturn = Color.fromRGBO(255, 43, 86, 1.0);

    if (StaticVariables.prefs == null)
      toReturn = Color.fromRGBO(255, 43, 86, 1.0); //Reddish
    else {
      String state = StaticVariables.prefs.getString("activerequeststate");
      switch (state) {
        case "Searching":
          toReturn = Color.fromRGBO(255, 43, 86, 1.0); //Reddish

          break;

        case "Cancelling":
          toReturn = Colors.black26; //BLACK

          Timer(Duration(seconds: 5), () {
            if (GlobalVar.Get("canpop", true)) {
              print('DESTROYING EVERYTHING because cancelled');
              Navigator.pop(context);
              GlobalVar.Set("canpop", false);
            }
          });

          break;

        case "Cancelled":
          toReturn = Color.fromRGBO(66, 66, 66, 1.0); //Dark grey

          if (GlobalVar.Get("canpop", true)) {
            print('DESTROYING EVERYTHING because cancelled');
            Navigator.pop(context);
            GlobalVar.Set("canpop", false);
          }

          break;

        case "Pending":
          toReturn = Color.fromRGBO(255, 174, 0, 1.0); //Orange

          break;

        case "Accepted":
          toReturn = Color.fromRGBO(30, 150, 18, 1.0); //Green

          break;
        case "Solved":
          toReturn = Colors.blueAccent; //Green
          Timer(Duration(seconds: 5), () {
            if (GlobalVar.Get("canpop", true)) {
              print('DESTROYING EVERYTHING because cancelled');
              Navigator.pop(context);
              GlobalVar.Set("canpop", false);
            }
          });

//          if (GlobalVar.Get("canpop", true)) {
////            Navigator.pop(context);
//            GlobalVar.Set("canpop", false);
//          }

          break;
      }
    }

    return toReturn;
  }

  Color requestColor = Color.fromRGBO(255, 43, 86, 1.0);

  void DoSearchAnimation() async {
    if (StaticVariables.prefs.getString("activerequeststate") != "Cancelled") {
      _circle1FadeController = new AnimationController(
          duration: new Duration(milliseconds: 2000), vsync: this);

      _circle1SizeController = new AnimationController(
          duration: new Duration(milliseconds: 2000), vsync: this);

      _radiusAnimation = new Tween<double>(begin: beginValue, end: endValue)
          .animate(new CurvedAnimation(
              curve: Curves.easeInSine, parent: _circle1SizeController));

      _fadeAnimation = new Tween<double>(begin: beginFade, end: endFade)
          .animate(new CurvedAnimation(
              curve: Curves.easeInSine, parent: _circle1FadeController));

      _circle1SizeController.addListener(() {
        if (this.mounted) {
          try {
            this.setState(() {});
          } catch (e) {}
        }
      });

      _circle1FadeController.addListener(() {
        if (this.mounted) {
          try {
            this.setState(() {});
          } catch (e) {}
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
    return WillPopScope(
      onWillPop: () {},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/SOS_Background.png"),
                    fit: BoxFit.fill)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: CircleAvatar(
                        child: SvgPicture.asset(
                          "assets/images/pin.svg",
                          color: Colors.white,
                          width: 100,
                          height: 150,
                        ),
                        radius: _radiusAnimation == null
                            ? beginValue
                            : _radiusAnimation.value,
                        backgroundColor: GetColorBasedOnState().withOpacity(
                            _fadeAnimation == null ? 1 : _fadeAnimation.value),
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
//
            )),
      ),
    );
  }
}

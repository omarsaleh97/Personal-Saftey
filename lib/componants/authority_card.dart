import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:personal_safety/componants/authority_data.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/models/api_response.dart';
import 'package:personal_safety/models/authorityType.dart';
import 'package:personal_safety/others/GlobalVar.dart';
import 'package:personal_safety/screens/search.dart';
import 'package:personal_safety/services/SocketHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class AuthorityCard extends StatefulWidget {
  final Authority authority;
  AuthorityCard({Key key, this.authority}) : super(key: key);

  @override
  _AuthorityCardState createState() => _AuthorityCardState(authority);
}

class _AuthorityCardState extends State<AuthorityCard> {

  int authType;

  _AuthorityCardState(Authority authority)
  {

    authType = authority.id;

  }

  void _value1Changed(bool value) {
    setState(() => _value1 = value);
    print("result = $value");
  }

  void _value2Changed(bool value) => setState(() => _value2 = value);
  Authority type;
  void initState() {
    type = widget.authority;
    super.initState();
  }

  bool _value1 = false;
  bool _value2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff006E90),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.symmetric(vertical: !type.isSelected ? 20 : 0),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15),
              child: type.name),
          Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 15),
              child: type.description),
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 13),
            child: Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 50,
                  height: 25,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      GlobalVar.Set("sosrequesttype", authType);
                      print("sosrequest type is now: " + GlobalVar.Get("sosrequesttype", authType).toString());
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Alert(
                              onchange1: _value1Changed,
                              onchange2: _value2Changed,
                            );
                          });
                    },
                    child: Text(
                      "Request",
                      style: TextStyle(color: Color(0xff006E90), fontSize: 12),
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 130,
                ),
                Stack(
                  children: <Widget>[type.image],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      pi / 2,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Alert extends StatefulWidget {
  bool value1;
  bool value2;

  Function onchange1;
  Function onchange2;

  Alert({this.value1, this.value2, this.onchange1, this.onchange2});
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  bool value1 = false;
  bool value2 = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CustomLoadingIndicator(
            customColor: grey,
          ))
        : AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      'assets/images/warning.svg',
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                      child: Text(
                    "Approve Request",
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(
                      child: Text(
                    "you are about to send request to arrive at your location."
                    "Please approve the follwing options and proceed",
                    style: TextStyle(fontSize: 13, color: grey),
                    textAlign: TextAlign.center,
                  )),
                ),
                CheckboxListTile(
                  value: value1,
                  onChanged: (value) {
                    widget.onchange1(value);
                    setState(() {
                      value1 = value;
                    });
                  },
                  title: new Text(
                    "Notify my Emergency Contact",
                    style: TextStyle(fontSize: 12),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.red,
                ),
                CheckboxListTile(
                  value: value2,
                  onChanged: (value) {
                    widget.onchange2(value);
                    setState(() {
                      value2 = value;
                    });
                  },
                  title: new Text("Notify my neighbourhood ",
                      style: TextStyle(fontSize: 12)),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.red,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 50.0,
                      width: 200,
                      child: RaisedButton(
                          child: Center(
                            child: Text(
                              "Request",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          color: Accent1,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            MakeSOSRequest(GlobalVar.Get("sosrequesttype", 1));
                          }),
                    ))
              ],
            ),
          );
  }

  void MakeSOSRequest(int requestType) async {
    print("About to make an SOS request with requestType " + requestType.toString());
    SocketHandler.SetActiveSOSRequestState("Searching");
    await SocketHandler.ConnectToClientChannel();
    SocketHandler.SendSOSRequest(requestType);
    GlobalVar.Set("canpop", true);
    print("canpop is now: " + GlobalVar.Get("canpop", false).toString());
    Navigator.pop(context);
    setState(() {
      _isLoading = true;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/models/sos_request_model.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/event_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SOSRequestItem extends StatefulWidget {
  final SOSRequestModel sosRequestModel;

  SOSRequestItem({@required this.sosRequestModel, Key key}) : super(key: key);

  @override
  _SOSRequestItemState createState() => _SOSRequestItemState();
}

class _SOSRequestItemState extends State<SOSRequestItem> {
  String imageItem;
  void setImage() {
    if (widget.sosRequestModel.authorityTypeName == "Police")
      imageItem = "assets/images/badge.png";
    else if (widget.sosRequestModel.authorityTypeName == "Ambulance")
      imageItem = "assets/images/ambulance.png";
    else if (widget.sosRequestModel.authorityTypeName == "Firefighting")
      imageItem = "assets/images/firefighter.png";
    else
      imageItem = "assets/images/tow-truck.png";
  }

  Future<bool> saveTokenPreference(String token, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = token;
    prefs.setString(key, value);
  }

  @override
  void initState() {
    setImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          height: 90,
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color(0xff006E90),
                  radius: 25,
                  child: Image.asset(
                    imageItem,
                    width: 30,
                    height: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          width: 240,
                          child:
//                              widget.event.description.length > 80
//                                  ? Text(
//                                      widget.event.description
//                                              .substring(0, 40) +
//                                          '...see more',
//                                overflow: TextOverflow.clip,
//                                maxLines: 2,
//                                softWrap: false,
//                                style: TextStyle(
//                                    color: primaryColor, fontSize: 13),
//                                    )
//                                  :
                              Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.sosRequestModel.authorityTypeName,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: greyIcon,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy').add_jm().format(
                                          DateTime.parse(widget.sosRequestModel
                                              .requestCreationDate)),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: widget.sosRequestModel
                                                    .requestStateName ==
                                                "Solved"
                                            ? Color(0xff16B68F)
                                            : Color(0xffFF2B56),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        widget.sosRequestModel
                                                    .requestStateName ==
                                                "Solved"
                                            ? "Solved"
                                            : 'Cancelled',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    ]);
  }
}

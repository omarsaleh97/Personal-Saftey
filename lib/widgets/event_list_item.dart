import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:personal_safety/providers/event.dart';
import 'package:personal_safety/screens/event_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventListItem extends StatefulWidget {
  final EventGetterModel eventGetter;

  EventListItem({@required this.eventGetter, Key key}) : super(key: key);

  @override
  _EventListItemState createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> {
  Future<bool> saveTokenPreference(String token, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = token;
    prefs.setString(key, value);
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
          height: 146,
          child: Card(
              child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('eventDetailsID', widget.eventGetter.id);

              var id = prefs.getInt("eventDetailsID");
              print('EVENT DETAILS ID FOR SERVICE $id');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventDetailScreen(
                            data: widget.eventGetter,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 120,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Image(
                        image: NetworkImage(
                            "https://personalsafety.azurewebsites.net/${widget.eventGetter.thumbnailUrl}"),
                        fit: BoxFit.cover,
                      ),
                      //margin: EdgeInsets.all(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.eventGetter.userName,
                          style: TextStyle(color: Colors.grey),
                        ),
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
                                Text(
                              widget.eventGetter.title,
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              softWrap: false,
                              style:
                                  TextStyle(color: primaryColor, fontSize: 13),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: widget.eventGetter.isPublicHelp ==
                                          false
                                      ? Container()
                                      : Row(
                                          children: <Widget>[
                                            Container(
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff006C8E),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.5),
                                                  child: Text(
                                                    "Public Help",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 3.5,
                                            ),
                                          ],
                                        )),
                              Container(
                                  child: widget.eventGetter.isValidated == false
                                      ? Container()
                                      : Container(
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Color(0xff388EA9),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.5),
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "Validated",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Icon(
                                                  Icons.check,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          )))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              DateFormat('dd/MM/yyyy').add_jm().format(
                                  DateTime.parse(
                                      widget.eventGetter.creationDate)),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Votes: ${widget.eventGetter.votes.toString()}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
//                                    IconButton(
//                                        icon: Icon(
//                                          Icons.favorite_border,
//                                          color: widget.eventGetter.isValidated
//                                              ? Colors.red
//                                              : Colors.grey,
//                                        ),
//                                        onPressed: () {
//                                          setState(() {
//                                            widget.eventGetter
//                                                .toggleFavoriteStatus();
//                                          });
//                                        }),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    ]);
  }
}

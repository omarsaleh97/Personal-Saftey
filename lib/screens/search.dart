import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  alertDialog() {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Color(0xffFF2B56),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Searching...',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Finding a nearby facility to help you.',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                        child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              child: CircleAvatar(
                child: CircleAvatar(
                  child: CircleAvatar(
                    child: SvgPicture.asset(
                      "assets/images/place-24px.svg",
                      color: Colors.white,
                      width: 100,
                      height: 150,
                    ),
                    radius: 110,
                    backgroundColor: Color(0xffFF2B56),
                  ),
                  radius: 130,
                  backgroundColor: Color(0xffFF2B56).withOpacity(0.3),
                ),
                radius: 150,
                backgroundColor: Color(0xffFF2B56).withOpacity(0.3),
              ) /* add child content here */,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 600),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: alertDialog(),
            ),
          ),
        ],
      ),
    );
  }
}

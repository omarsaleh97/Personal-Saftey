import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/screens/home.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
                        "A facility operator was about to accept your request,are sure you want to cancel the pending request?",
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
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              child: Text("cancel",style: TextStyle(color:  Color(0xffFF2B56),fontSize: 18),),
            )
          )
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
                      "Searching..",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    iconSize: 20,
                    color: Colors.white,
                    icon: Icon(Icons.close),
                    onPressed: () {
                      //Navigator.pop(context);
                      CancelAlertDialog();
                    },
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
  }

  @override
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

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

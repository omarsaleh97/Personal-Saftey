import 'package:flutter/material.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/test.dart';
import 'package:personal_safety/screens/news.dart';
import 'package:personal_safety/screens/tabs/NearbyEvent.dart';
import 'package:personal_safety/screens/tabs/PublicEvent.dart';
import 'package:personal_safety/screens/main_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome. Stay Safe!'),
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event_available),
            title: Text('Test Notifications'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Test()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPassword()));
            },
          ),
          Divider(),
//          ListTile(
//            leading: Icon(Icons.event),
//            title: Text('Nearby Event'),
//            onTap: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyEvent()));
//            },
//          ),
        ],
      ),
    );
  }
}
